import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_demo/src/app_data.dart';
import 'package:prueba_demo/src/transaction_screen.dart'; // Asegúrate de importar AppData

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  String _amount = '0';

  void _onNumberPress(String number) {
    setState(() {
      if (_amount == '0') {
        _amount = number;
      } else {
        _amount += number;
      }
    });
  }

  void _onDeletePress() {
    setState(() {
      if (_amount.length > 1) {
        _amount = _amount.substring(0, _amount.length - 1);
      } else {
        _amount = '0';
      }
    });
  }

  void _onContinuePress() {
    final appData = Provider.of<AppData>(context, listen: false);
    double amountToSend = double.parse(_amount);

    if (amountToSend > 0 && amountToSend <= appData.availableBalance) {
      appData.sendMoney(amountToSend, 'Alex Banz');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const TransactionSuccessScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ingrese un monto válido.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Imagen de perfil
              ),
              title: Text('Emma Vega'),
              subtitle: Text('AC : 159107-6395'),
              trailing: Icon(Icons.arrow_forward),
            ),
            const Divider(),
            Center(
              child: Text(
                'Gs $_amount',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1,
                ),
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  if (index < 9) {
                    return _buildNumberButton((index + 1).toString());
                  } else if (index == 9) {
                    return _buildEmptyButton();
                  } else if (index == 10) {
                    return _buildNumberButton('0');
                  } else {
                    return _buildDeleteButton();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onContinuePress,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 227, 169, 246),
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text('SEND!'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () {
        _onNumberPress(number);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(),
        minimumSize: const Size(60, 60), // Ajustar el tamaño del botón
      ),
      child: Text(
        number,
        style: const TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }

  Widget _buildEmptyButton() {
    return const SizedBox.shrink();
  }

  Widget _buildDeleteButton() {
    return ElevatedButton(
      onPressed: _onDeletePress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(),
        minimumSize: const Size(60, 60), // Ajustar el tamaño del botón
      ),
      child: const Icon(
        Icons.backspace,
        color: Colors.black,
      ),
    );
  }
}
