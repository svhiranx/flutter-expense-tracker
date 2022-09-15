import 'package:expense_tracker/chartbar.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  @override
  final List<Transaction> recentTx;
  Chart(this.recentTx);
  double get total {
    return groupedTxValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  List<Map<String, Object>> get groupedTxValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double amount = 0;
      for (int i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekday.day &&
            transactions[i].date.month == weekday.month &&
            transactions[i].date.year == weekday.year)
          amount += transactions[i].amount;
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': amount
      };
    }).reversed.toList();
  }

  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        margin: EdgeInsets.all(25),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: groupedTxValues.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(e['day'], e['amount'],
                    total == 0 ? 0 : (e["amount"] as double) / total),
              );
            }).toList(),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ));
  }
}
