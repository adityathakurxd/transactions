import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:transactions/models/transaction_model.dart';
import 'package:transactions/providers/transaction_provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final AsyncValue transactions = ref.watch(transactionProvider);
        final AsyncValue dailySpending = ref.watch(dailySpendingProvider);

        return Center(
          child: switch (transactions) {
            AsyncData(:final value) => TransactionsGrid(transactions: value),
            AsyncError(:final error) =>
              Text('Oops, something unexpected happened $error'),
            _ => const CircularProgressIndicator(),
          },
        );
      },
    );
  }
}

class TransactionsGrid extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsGrid({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 30), // 7 days a week
      itemCount: 365,
      itemBuilder: (context, index) {
        Color color = _getColorForSpending(transactions[index].amount);
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                // return ListView.builder(
                //   itemCount: transactionsForDay.length,
                //   itemBuilder: (context, index) {
                //     Transaction transaction = transactionsForDay[index];
                return ListTile(
                  title: Text(
                      DateFormat.yMMMMd().format(transactions[index].date)),
                  subtitle: const Text("Mock Transaction"),
                  trailing: Text(transactions[index].amount.toStringAsFixed(2)),
                );
                //   },
                // );
              },
            );
          },
          child: Container(
            color: color,
            margin: const EdgeInsets.all(2.0),
          ),
        );
      },
    );
  }

  Color _getColorForSpending(double spending) {
    // Define color scale here
    if (spending == 0) {
      return Colors.white;
    } else if (spending < 50) {
      return Colors.lightGreen;
    } else if (spending < 100) {
      return Colors.green;
    } else {
      return const Color.fromARGB(255, 6, 77, 8);
    }
  }
}
