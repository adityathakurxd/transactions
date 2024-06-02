import 'dart:math';

class Transaction {
  final String category;
  final double amount;
  final bool isCredit;

  Transaction(
      {required this.category, required this.amount, required this.isCredit});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        category: json['category'],
        amount: json['amount'].toDouble(),
        isCredit: json['isCredit']);
  }

  Map<String, dynamic> toJson() =>
      {'category': category, 'amount': amount, 'isCredit': isCredit};
}

class DailyTransactions {
  final DateTime date;
  final double totalAmountSpent;

  final List<Transaction> transactions;

  DailyTransactions({
    required this.date,
    required this.totalAmountSpent,
    required this.transactions,
  });

  factory DailyTransactions.fromJson(Map<String, dynamic> json) {
    var list = json['transactions'] as List;
    List<Transaction> transactionsList =
        list.map((i) => Transaction.fromJson(i)).toList();

    return DailyTransactions(
      date: DateTime.parse(json['date']),
      totalAmountSpent: json['totalAmountSpent'].toDouble(),
      transactions: transactionsList,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'totalAmountSpent': totalAmountSpent,
        'transactions': transactions.map((t) => t.toJson()).toList(),
      };
}

/// Code to generate some mock data for the grid

List<DailyTransactions> generateMockData() {
  List<DailyTransactions> dailyTransactionsList = [];
  DateTime now = DateTime.now();
  List<String> categories = [
    'Food',
    'Shopping',
    'Travel',
    'Entertainment',
    'Health'
  ];

  Random random = Random();

  for (int i = 0; i < 365; i++) {
    DateTime date = now.subtract(Duration(days: i));
    List<Transaction> transactions = [];
    double totalAmountSpent = 0.0;

    // Monthly salary credit
    if (date.day == 1) {
      transactions.add(Transaction(
        category: 'Salary',
        amount: 5000.0 + random.nextDouble() * 1000, // Salary range
        isCredit: true,
      ));
    }

    // Random friend transfer credit
    if (random.nextDouble() < 0.05) {
      // 5% chance of receiving money from a friend
      transactions.add(Transaction(
        category: 'Received from Friend',
        amount: 50.0 + random.nextDouble() * 200, // Random amount from friend
        isCredit: true,
      ));
    }

    // Daily expenses debit
    double dailyExpenseTotal = random.nextDouble() * 1000;
    List<double> amounts =
        _generateRandomAmounts(dailyExpenseTotal, categories.length, random);

    for (int j = 0; j < categories.length; j++) {
      transactions.add(Transaction(
        category: categories[j],
        amount: amounts[j],
        isCredit: false,
      ));
      totalAmountSpent += amounts[j];
    }

    dailyTransactionsList.add(DailyTransactions(
      date: date,
      totalAmountSpent: totalAmountSpent,
      transactions: transactions,
    ));
  }

  return dailyTransactionsList;
}

List<double> _generateRandomAmounts(double total, int parts, Random random) {
  List<double> amounts = [];
  double remaining = total;

  for (int i = 0; i < parts - 1; i++) {
    double amount = remaining * random.nextDouble();
    amounts.add(amount);
    remaining -= amount;
  }
  amounts.add(remaining);

  return amounts;
}

double calculateTotalSpending(List<DailyTransactions> transactions) {
  return transactions
      .expand((daily) => daily.transactions)
      .where((transaction) => !transaction.isCredit)
      .fold(0.0, (sum, transaction) => sum + transaction.amount);
}
