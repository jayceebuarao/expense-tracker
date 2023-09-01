import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _costController = TextEditingController();

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
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            controller: _costController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '\$',
              label: Text('Cost Amount'),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  print('Cancel');
                },
                child: const Text('Cancel'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  print('Title: ${_titleController.text}');
                  print('Cost Amount: ${_costController.text}');
                },
                child: const Text('Save'),
              )
            ],
          )
        ],
      ),
    );
  }
}
