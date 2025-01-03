import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF004E97),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Color(0xFFFFC300)),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Text(
                  expense.amount.toStringAsFixed(2),
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expense.category],
                      color: Color(0xFFFFC300),
                    ),
                    SizedBox(width: 10),
                    Text(
                      expense.getFormatedDate,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
