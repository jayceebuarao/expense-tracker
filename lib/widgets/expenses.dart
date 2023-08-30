import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

// A stateful widget will always have 2 classes: the widget class and the state class

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    final List<Expense> _registeredExpenses = [
      Expense(
          title: 'Flutter Course',
          amount: 13.99,
          date: DateTime.now(),
          category: Category.work),
      Expense(
          title: 'Ice Cream',
          amount: 1.99,
          date: DateTime.now(),
          category: Category.food),
      Expense(
          title: 'Spa Day',
          amount: 100.99,
          date: DateTime.now(),
          category: Category.leisure),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
