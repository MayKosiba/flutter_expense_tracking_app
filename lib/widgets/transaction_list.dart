import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(
      this.transactions, void Function(String id) this.deleteTransaction,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('\$${transactions[index].amount}'),
                ),
              ),
            ),
            title: Text(transactions[index].title),
            subtitle: Text(
              DateFormat.yMMMd().format(transactions[index].date),
            ),
            trailing: IconButton(
              onPressed: () => deleteTransaction(transactions[index].id),
              icon: const Icon(
                Icons.delete,
              ),
              color: Theme.of(context).errorColor,
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
