import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/pages/expences.dart';
import 'package:expense_tracker_app/server/category_adapter.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox("expenseDatabase");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: Expences(),
    );
  }
}
