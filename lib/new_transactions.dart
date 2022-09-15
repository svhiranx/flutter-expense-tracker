import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addtx;
  NewTransactions(this.addtx);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime pickedDate;

  void submitdata() {
    final enteredtitle = titleController.text;
    final enteredamount = double.parse(amountController.text);
    if (enteredamount == 0 || enteredtitle.isEmpty || pickedDate == null) {
      return;
    }
    widget.addtx(enteredtitle, enteredamount, pickedDate);
    Navigator.of(context).pop();
  }

  void datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                submitdata();
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    pickedDate == null
                        ? 'No date chosen'
                        : DateFormat('dd/MM/yyyy').format(pickedDate),
                  ),
                ),
                FlatButton(
                    onPressed: datepicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
              ],
            ),
            RaisedButton(
              onPressed: () {
                submitdata();
              },
              child: Text(
                'Add transaction',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
