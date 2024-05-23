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
  final List<DailyTransactions> transactions;

  const TransactionsGrid({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 30),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        Color color = _getColorForSpending(transactions[index].amount);
        return GestureDetector(
          onTap: () {
            if (transactions[index].transactions.length > 1) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView.builder(
                    itemCount: transactions[index].transactions.length,
                    itemBuilder: (context, innerIndex) {
                      Transaction transaction =
                          transactions[index].transactions[innerIndex];
                      return ListTile(
                        title: Text(transaction.category),
                        subtitle: Text(DateFormat.yMMMMd()
                            .format(transactions[index].date)),
                        trailing: Text(transaction.amount.toStringAsFixed(2)),
                      );
                    },
                  );
                },
              );
            } else {
              print('No transaction available at index 1');
            }
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
    if (spending == 0) {
      return Colors.white;
    } else if (spending < 50) {
      return const Color.fromARGB(255, 5, 246, 13);
    } else if (spending < 100) {
      return const Color.fromARGB(255, 4, 198, 10);
    } else {
      return const Color.fromARGB(255, 2, 130, 6);
    }
  }
}
