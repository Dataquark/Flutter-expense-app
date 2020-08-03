import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTx;

  NewTransaction(this.addNewTx);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    // dummy data validation that stops the execution if true
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    // this is not executed if the above validation is true
    widget.addNewTx(
      enteredTitle,
      enteredAmount,
    );

    // to close the modal sheet after submission
    Navigator.of(context).pop();
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
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              // we get an argument but we do not care, (_)
              onSubmitted: (_) => submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              // we get an argument but we do not do anything with it
              onSubmitted: (_) => submitData(),
              // onChanged: (val) {
              //   amountInput = val;
              // },
            ),
            FlatButton(
              // color: Colors.purple,
              onPressed: submitData,
              textColor: Colors.purple,
              child: Text(
                "Add transaction",
              ),
            )
          ],
        ),
      ),
    );
  }
}
