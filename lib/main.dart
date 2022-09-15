import 'package:expense_tracker/new_transactions.dart';
import 'package:expense_tracker/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction_list.dart';
import 'chart.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Tracker',
        home: MyHomePage(),
        theme: ThemeData(primarySwatch: Colors.purple));
  }
}

List<Transaction> transactions = [];

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String tit, amt, dat;

  void _addtransaction(String title, double amount, DateTime date) {
    String id = DateTime.now().toString();
    final tx = Transaction(id: id, title: title, amount: amount, date: date);
    setState(() {
      transactions.insert(0, tx);
    });
  }

  void _deleteTx(String id) {
    setState(() {
      transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void startAddNewTransaction(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransactions(_addtransaction);
        });
  }

  List<Transaction> get recentTx {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text('Expense Tracker'),
      actions: [
        IconButton(
            onPressed: () {
              startAddNewTransaction(context);
            },
            icon: Icon(Icons.add_box_rounded))
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            child: Chart(recentTx),
            height: (MediaQuery.of(context).size.height -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.top -
                    150) *
                0.3,
          ),
          Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(transactions, _deleteTx))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(
          Icons.add_circle,
        ),
      ),
    );
  }
}
