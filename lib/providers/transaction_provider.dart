import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transactions/models/transaction_model.dart';

final transactionProvider = FutureProvider.autoDispose((ref) async {
  return generateMockData();
});

final dailySpendingProvider = FutureProvider.autoDispose((ref) async {
  final transactions = generateMockData();

  return aggregateTransactions(transactions);
});
