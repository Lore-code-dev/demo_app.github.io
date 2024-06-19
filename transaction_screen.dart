import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_demo/src/app_data.dart';

class TransactionSuccessScreen extends StatelessWidget {
  const TransactionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transacción Exitosa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            Text(
              'Transacción exitosa\nSaldo disponible: Gs ${appData.availableBalance}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
