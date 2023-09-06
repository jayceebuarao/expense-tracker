import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
// A stateful widget will always have 2 classes: the widget class and the state class

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  //_registeredExpenses populated with temporary data
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
        amount: 65.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  //update state when new expense item is added to list
  void _updateExpenses(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  //update state when expense item is removed from list
  void _removeExpenseItem(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    //snackbar to show delete action
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //clear snackbars before showing new snackbars
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted.'),
        action: SnackBarAction(
          //option to undo delete action
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex,
                  expense); //insert deleted item back to original position
            });
          },
        ),
      ),
    );
  }

  //show modal for new item form
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        updateExpenses: _updateExpenses,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text(
          'No Expenses so far! :) Start adding your expenses through \'+\''),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpenseItem,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent),
                ],
              ));
  }
}
