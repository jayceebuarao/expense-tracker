import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      //entire app theme modified through theme property in MaterialApp() class
      //but directly modifying properties inside on ThemeData() class tells flutter that everything will be customized
      //To work around that and if preferred to keep other default properties use '.copywith' constructor
      theme: ThemeData().copyWith(useMaterial3: true),
      home: const Expenses(),
    ),
  );
}
