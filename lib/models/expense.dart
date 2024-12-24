import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4();

final formateDate = DateFormat.yMd();

enum Category { food, travel, leasure, work }

final categoryIcons = {
  Category.food: Icons.fastfood,
  Category.leasure: Icons.sports_esports,
  Category.travel: Icons.flight,
  Category.work: Icons.computer,
};

class ExpenseModel {
  ExpenseModel(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //getter > formated date
  String get getFormatedDate {
    return formateDate.format(date);
  }
}
