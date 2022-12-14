import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    addTransaction(
      enteredTitle,
      enteredAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.purple),
              onPressed: submitData,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
