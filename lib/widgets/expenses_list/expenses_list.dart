import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses}); //arguments

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    //Listview widget is build with a constructor function
    //builder produces widgets as they are shown on the screen
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Text(expenses[index].title),
    );
  }
}
