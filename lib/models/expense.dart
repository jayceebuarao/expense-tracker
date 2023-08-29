import 'package:uuid/uuid.dart';

const uuid = Uuid(); //dart package that generate unique IDs

//data model
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4(); //Initializer list used for non function arguments

  final String id;
  final String title;
  final double amount;
  final DateTime date;
}
