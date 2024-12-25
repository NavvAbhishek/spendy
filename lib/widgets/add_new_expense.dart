import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key});

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  Category selectedCategory = Category.leasure;

  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  DateTime selectedDate = DateTime.now();

  Future<void> openDateModal() async {
    try {
      final pickedDate = await showDatePicker(
          context: context, firstDate: firstDate, lastDate: lastDate);
      setState(() {
        selectedDate = pickedDate!;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: "Add new expense title", label: Text("title")),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                      hintText: "Enter the amount", label: Text("amount")),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(formateDate.format(selectedDate)),
                  IconButton(
                      onPressed: openDateModal,
                      icon: Icon(Icons.date_range_outlined))
                ],
              ))
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val!;
                    });
                  }),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.redAccent)),
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blueAccent)),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}
