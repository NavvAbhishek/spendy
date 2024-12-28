import 'package:expense_tracker_app/models/expense.dart';
import 'package:hive/hive.dart';

class Database {
  //? create a database reference
  final myBox = Hive.box("expenseDatabase");

  List<ExpenseModel> expenseList = [];

  void createInitialDb() {
    expenseList = [
      ExpenseModel(
          amount: 1200.00,
          date: DateTime.now(),
          title: "Football",
          category: Category.leasure),
      ExpenseModel(
          amount: 1000.00,
          date: DateTime.now(),
          title: "Pizza",
          category: Category.food)
    ];
  }

  // load data
  void loadData() {
    final dynamic data = myBox.get("EXP_DATA");
    //validate the data
    if (data != null && data is List<dynamic>) {
      expenseList = data.cast<ExpenseModel>().toList();
    }
  }

  // update data
  Future<void> updateData() async {
    await myBox.put("EXP_DATA", expenseList);
    print("data saved");
  }
}
