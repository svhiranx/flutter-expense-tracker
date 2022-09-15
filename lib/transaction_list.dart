import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Function deltx;
  @override
  List<Transaction> transactions;
  TransactionList(this.transactions, this.deltx);
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? Column(
              children: [
                const Text(
                  'No Transactions added',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                    height: 100,
                    child: Image.asset('images/waiting.png', fit: BoxFit.cover))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                                '₹${transactions[index].amount.toStringAsFixed(2)}'),
                          ),
                        ),
                        radius: 30),
                    title: Text(transactions[index].title),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deltx(transactions[index].id);
                      },
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
