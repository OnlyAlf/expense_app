import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final inputTitle = _titleController.text;
    final inputAmount = double.parse(_amountController.text);

    if (inputTitle.isEmpty || inputAmount <= 0 || _selectedDate == null) return;

    widget.addTx(
      inputTitle,
      inputAmount,
      _selectedDate
    );

    Navigator.of(context).pop();
  }

  void _presentDayPicker() {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()).then((date) {
      if(date == null){
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              onSubmitted: (_) => _submitData,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_selectedDate == null ? 'No Date Chosen!': 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      "Choose Date!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDayPicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              onPressed: _submitData,
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
