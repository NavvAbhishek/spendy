import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expense_list.dart';
import 'package:flutter/material.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  final List<ExpenseModel> _expenseList = [
    ExpenseModel(
        amount: 1200.00,
        date: DateTime.now(),
        title: "Football",
        category: Category.leasure),
    ExpenseModel(
        amount: 1000.00,
        date: DateTime.now(),
        title: "Pizza",
        category: Category.food)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spendy"),
        backgroundColor: Colors.blue,
        actions: [
          Container(
              color: Colors.yellow,
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)))
        ],
      ),
      body: Column(
        children: [
          ExpenseList(
            expenseList: _expenseList,
          )
        ],
      ),
    );
  }
}
