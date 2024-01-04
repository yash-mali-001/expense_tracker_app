import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { food, travel, rent, stationary, mobileBills, clothing }

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.travel: Icons.mode_of_travel,
  Category.rent: Icons.home,
  Category.stationary: Icons.account_balance_wallet,
  Category.mobileBills: Icons.mobile_screen_share,
  Category.clothing: Icons.all_inclusive,
};

class Expense {
  Expense({
    required this.amount,
    required this.title,
    required this.category,
    required this.date, // v4 method generates the unique id
  }) : id = uuid
            .v4(); // "initializer list" can be used to initialize class properties with values that are not received from constructor

  final String
      id; // We have to create a new id every time as expense is widget is added .. hence we will import uuid package
  final String title;
  final double amount;
  final DateTime date;
  final Category
      category; // if we accept a string for category unwanted categories might be introduced
  // eg if want to add 'Food' but while adding we can accidentally add Foood and it will also be accepted
  // if we keep type of category as String //Hence to avoid this we can use enum

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
