import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transactions/models/transaction_model.dart';

final transactionProvider = FutureProvider.autoDispose((ref) async {
  /// Code to generate some mock data, can be replaced with an API call to server
  return generateMockData();
});
