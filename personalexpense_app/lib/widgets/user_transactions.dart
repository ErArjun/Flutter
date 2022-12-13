import 'package:flutter/cupertino.dart';
import '../models/transaction.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transcation_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'shoes',
      amount: 1200,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'shirt',
      amount: 1200,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactoionList(_userTransactions),
      ],
    );
  }
}
