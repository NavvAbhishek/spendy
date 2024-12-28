import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/server/database.dart';
import 'package:expense_tracker_app/widgets/add_new_expense.dart';
import 'package:expense_tracker_app/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:expense_tracker_app/server/database.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  final myBox = Hive.box("expenseDatabase");
  Database db = Database();

  Map<String, double> dataMap = {
    "Food": 0,
    "Travel": 0,
    "Leasure": 0,
    "Work": 0,
  };

  void onAddNewExpense(ExpenseModel expense) {
    setState(() {
      db.expenseList.add(expense);
      calCategoryValues();
    });
    db.updateData();
  }

  void onDeleteExpense(ExpenseModel expense) {
    //? store the deleting expense
    ExpenseModel deletingExpense = expense;
    //? get the index of removing expense
    final int removingIndex = db.expenseList.indexOf(expense);
    setState(() {
      db.expenseList.remove(expense);
      db.updateData();
      calCategoryValues();
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Delete Successfull"),
        action: SnackBarAction(
            label: "undo",
            onPressed: () {
              setState(() {
                db.expenseList.insert(removingIndex, deletingExpense);
                db.updateData();
                calCategoryValues();
              });
            })));
  }

  // function to open a model overlay
  void openAddExpencesOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddNewExpense(
          onAddExpense: onAddNewExpense,
        );
      },
    );
  }

  //? pie chart
  double foodVal = 0;
  double travelVal = 0;
  double leasureVal = 0;
  double workVal = 0;

  void calCategoryValues() {
    double foodValTotal = 0;
    double travelValTotal = 0;
    double leasureValTotal = 0;
    double workValTotal = 0;

    for (final expense in db.expenseList) {
      if (expense.category == Category.food) {
        foodValTotal += expense.amount;
      }
      if (expense.category == Category.leasure) {
        leasureValTotal += expense.amount;
      }
      if (expense.category == Category.work) {
        workValTotal += expense.amount;
      }
      if (expense.category == Category.travel) {
        travelValTotal += expense.amount;
      }
    }

    setState(() {
      foodVal = foodValTotal;
      travelVal = travelValTotal;
      workVal = workValTotal;
      leasureVal = leasureValTotal;
    });

    //? update data map
    dataMap = {
      "Food": foodVal,
      "Travel": travelVal,
      "Leasure": leasureVal,
      "Work": workVal,
    };
  }

  @override
  void initState() {
    super.initState();

    // if this is the first time create the initial data
    if (myBox.get("EXP_DATA") == null) {
      db.createInitialDb();
      calCategoryValues();
    } else {
      db.loadData();
      calCategoryValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spendy"),
        backgroundColor: Colors.blue,
        actions: [
          Container(
              color: Colors.yellow,
              child: IconButton(
                  onPressed: openAddExpencesOverlay,
                  icon: const Icon(Icons.add)))
        ],
      ),
      body: Column(
        children: [
          PieChart(dataMap: dataMap),
          ExpenseList(
            expenseList: db.expenseList,
            onDeleteExpense: onDeleteExpense,
          )
        ],
      ),
    );
  }
}
