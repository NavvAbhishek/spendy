import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/server/database.dart';
import 'package:expense_tracker_app/widgets/add_new_expense.dart';
import 'package:expense_tracker_app/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

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

  static const Color foodColor = Colors.red;
  static const Color travelColor = Colors.blue;
  static const Color leisureColor = Colors.green;
  static const Color workColor = Color(0xFFFFD60A);

  List<Color> colorList = [foodColor, travelColor, leisureColor, workColor];

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
        backgroundColor: Color(0xFF001D3D),
        actions: [
          Container(
              color: Color(0xFFFFC300),
              child: IconButton(
                  onPressed: openAddExpencesOverlay,
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xFF001D3D),
                  )))
        ],
      ),
      body: Column(
        children: [
          PieChart(
            dataMap: dataMap,
            colorList: colorList,
            chartType: ChartType.disc,
            animationDuration: const Duration(milliseconds: 800),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              decimalPlaces: 1,
            ),
            legendOptions: const LegendOptions(
              showLegends: true,
              legendPosition: LegendPosition.right,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 10),
          ExpenseList(
            expenseList: db.expenseList,
            onDeleteExpense: onDeleteExpense,
          )
        ],
      ),
    );
  }
}
