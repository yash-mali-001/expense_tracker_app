import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    // Specially used for design purpose , we can add shadow some elevation etc...
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('\u{20B9} ${expense.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                    )), //Only 2 decimal values will be showed after decimal point
                const Spacer(), // it is the widget that can be used inside row or column and that takes maximum width between the two widgets in which it is placed
                Row(children: [
                  Icon(categoryIcons[expense.category], size: 30),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    expense.formattedDate,
                    style: const TextStyle(fontSize: 16),
                  ),
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
