import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'expense.g.dart';

final uuid = const Uuid().v4();

final formateDate = DateFormat.yMd();

enum Category { food, travel, leasure, work }

final categoryIcons = {
  Category.food: Icons.fastfood,
  Category.leasure: Icons.sports_esports,
  Category.travel: Icons.flight,
  Category.work: Icons.computer,
};

@HiveType(typeId: 1)
class ExpenseModel {
  ExpenseModel(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid;

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Category category;

  //getter > formated date
  String get getFormatedDate {
    return formateDate.format(date);
  }
}
