import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expense_tile.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final void Function(ExpenseModel expense) onDeleteExpense;
  final List<ExpenseModel> expenseList;

  const ExpenseList(
      {super.key, required this.expenseList, required this.onDeleteExpense});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenseList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Dismissible(
                key: ValueKey(expenseList[index]),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  onDeleteExpense(expenseList[index]);
                },
                child: ExpenseTile(
                  expense: expenseList[index],
                ),
              ),
            );
          }),
    );
  }
}
