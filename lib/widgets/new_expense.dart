import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.updateExpenses});

  final void Function(dynamic) updateExpenses;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _costController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitNewExpenseData() {
    final enteredCost = double.tryParse(_costController.text);
    final costIsInvalid = enteredCost == null || enteredCost <= 0;
    if (_titleController.text.isEmpty ||
        costIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please enter a valid title, amount, date, and category.'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Okay'),
                  )
                ],
              )));
      return;
    }
    widget.updateExpenses(Expense(
        title: _titleController.text,
        amount: enteredCost,
        date: _selectedDate!,
        category: _selectedCategory!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    //called after NewExpense Widget is closed
    _titleController
        .dispose(); //TextEditingController must be disposed as it is stored in memory after use
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _costController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Cost Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month_outlined))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          DropdownButton(
              hint: Text('Select a Category'),
              isExpanded: true,
              value: _selectedCategory,
              items: Category.values
                  .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase())))
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedCategory = value;
                });
              }),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); //removes widget from screen
                },
                child: const Text('Cancel'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitNewExpenseData,
                child: const Text('Save'),
              )
            ],
          )
        ],
      ),
    );
  }
}
