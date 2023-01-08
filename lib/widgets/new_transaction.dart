import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.addTx});

  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? selectedDate;

  void _submitData() {
    final title = titleController.text;
    final amount = amountController.text;

    if (title.isEmpty || amount.isEmpty || selectedDate == null) {
      return;
    }

    widget.addTx(
      title,
      double.parse(amount),
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                onSubmitted: (_) => _submitData(),
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? 'No Date Chosen!'
                            : DateFormat.yMd().format(selectedDate!).toString(),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () => _presentDatePicker(context),
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                ),
                onPressed: () => _submitData(),
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
