import 'package:uuid/uuid.dart';

const uuid = Uuid(); //dart package that generate unique IDs

//enums are custom type
enum Category { food, travel, leisure, work }

//data model
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //Initializer list used for non function arguments

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
