import 'package:expense_tracker/ExpensesList.dart';
import 'package:expense_tracker/InputExpense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }

}

class _Expenses extends State<Expenses> {
  List<Expense> dummyData =  [
    Expense(title: "testing", amount: 20.1, category: Category.food, date: DateTime.now()),
    Expense(title: "testing 2", amount: 25.1, category: Category.fashion,date: DateTime.now()),
    Expense(title: "testing 3", amount: 55.1, category: Category.live,date: DateTime.now()),
  ];

  void _addExpenseData(Expense val) {
    setState(() {
      dummyData.add(val);
    });
  }

  void _removeExpense(Expense val) {
    final expIdx = dummyData.indexOf(val);
    setState(() {
      dummyData.remove(val);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              dummyData.insert(expIdx, val);
            });
          },
        ),
          content: const Text("Expense deleted"))
    );
  }

  void _inputSheet() {
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder: (ctx) => InputExpense(_addExpenseData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(onPressed: _inputSheet, icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: Colors.yellowAccent,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Title"),
            Expanded(child: ExpensesList(dummyData, _removeExpense)),
          ],
        ),
      )
    );
  }
}