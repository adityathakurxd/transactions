import 'dart:math';

class Transaction {
  final String category;
  final double amount;

  Transaction({required this.category, required this.amount});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      category: json['category'],
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'amount': amount,
      };
}

class DailyTransactions {
  final DateTime date;
  final double amount;
  final String description;
  final List<Transaction> transactions;

  DailyTransactions({
    required this.date,
    required this.amount,
    required this.description,
    required this.transactions,
  });

  factory DailyTransactions.fromJson(Map<String, dynamic> json) {
    var list = json['transactions'] as List;
    List<Transaction> transactionsList =
        list.map((i) => Transaction.fromJson(i)).toList();

    return DailyTransactions(
      date: DateTime.parse(json['date']),
      amount: json['amount'].toDouble(),
      description: json['description'],
      transactions: transactionsList,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'amount': amount,
        'description': description,
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
    double totalAmount = random.nextDouble() * 1000;
    List<double> amounts =
        _generateRandomAmounts(totalAmount, categories.length, random);

    for (int j = 0; j < categories.length; j++) {
      transactions
          .add(Transaction(category: categories[j], amount: amounts[j]));
    }

    dailyTransactionsList.add(DailyTransactions(
      date: date,
      amount: totalAmount,
      description: 'Mock transactions for the day',
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
