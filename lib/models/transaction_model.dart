import 'dart:math';

class Transaction {
  final DateTime date;
  final double amount;
  final String description;

  Transaction(
      {required this.date, required this.amount, required this.description});
}

List<Transaction> generateMockData() {
  List<Transaction> transactions = [];
  DateTime now = DateTime.now();
  for (int i = 0; i < 365; i++) {
    DateTime date = now.subtract(Duration(days: i));
    transactions.add(Transaction(
      date: date,
      amount: (Random().nextDouble() * 200), // Random amount for mock data
      description: 'Mock transaction',
    ));
  }
  return transactions;
}

Map<DateTime, double> aggregateTransactions(List<Transaction> transactions) {
  Map<DateTime, double> dailySpending = {};
  for (var transaction in transactions) {
    DateTime date = DateTime(
        transaction.date.year, transaction.date.month, transaction.date.day);
    if (dailySpending.containsKey(date)) {
      dailySpending[date] = dailySpending[date]! + transaction.amount;
    } else {
      dailySpending[date] = transaction.amount;
    }
  }
  return dailySpending;
}
