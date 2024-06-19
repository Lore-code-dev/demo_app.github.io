import 'package:flutter/foundation.dart';

class Transaction {
  final String recipientName;
  final double amount;
  final DateTime dateTime;
  final String reference;

  Transaction({
    required this.recipientName,
    required this.amount,
    required this.dateTime,
    required this.reference,
  });
}

class AppData extends ChangeNotifier {
  double availableBalance = 995000; // Cantidad inicial de dinero disponible
  List<Transaction> transactions = [];

  void sendMoney(double amount, String recipientName) {
    if (amount > 0 && amount <= availableBalance) {
      availableBalance -= amount;
      transactions.add(Transaction(
        recipientName: recipientName,
        amount: amount,
        dateTime: DateTime.now(),
        reference: 'REF${transactions.length + 1}',
      ));
      notifyListeners(); // Notificar a los widgets que escuchan los cambios en el estado
    }
  }
}
