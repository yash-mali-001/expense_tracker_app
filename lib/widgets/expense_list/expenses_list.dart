import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {required this.expenses, required this.onRemoveExpense, super.key});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    // List views are always scrollable ..but builder on shows when listItems must be visible else hides them
    //Function that we pass to a itemBuilder must return a widget
    // Num of items Build depends on the listCount , index is assigned to each item starting from 0
    return ListView.builder(
      // Using builder constructor widgets are created whenever needed
      //key is associated with each widget to be uniquely identified ..
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.74),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expense: expenses[index])),
      itemCount: expenses.length,
    );
  }
}
