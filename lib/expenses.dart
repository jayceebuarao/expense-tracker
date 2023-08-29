import 'package:flutter/material.dart';

// A stateful widget will always have 2 classes: the widget class and the state class

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('Hello World'),
        ],
      ),
    );
  }
}
