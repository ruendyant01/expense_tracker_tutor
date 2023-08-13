import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class InputExpense extends StatefulWidget {
  const InputExpense(this.onAddExpense, {super.key});

  final void Function(Expense val) onAddExpense;

  @override
  State<InputExpense> createState() {
    return _InputExpense();
  }
}

class _InputExpense extends State<InputExpense> {
  _InputExpense();

  final username = TextEditingController();
  final amount = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedValue = Category.food;

  @override
  void dispose() {
    username.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
      child: Column(
        children: [
          TextField(
            controller: username,
            maxLength: 20,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Amount", prefixText: "\$"),
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  Text(_selectedDate == null
                      ? "No selected date"
                      : DateFormat('dd-MM-yyyy').format(_selectedDate!)),
                  IconButton(
                      onPressed: () async {
                        var nows = DateTime.now();
                        final dates = await showDatePicker(
                            context: context,
                            initialDate: nows,
                            firstDate:
                                DateTime(nows.year - 1, nows.month, nows.day),
                            lastDate:
                                DateTime(nows.year, nows.month, nows.day));
                        setState(() {
                          _selectedDate = dates;
                        });
                      },
                      icon: const Icon(Icons.date_range_outlined))
                ],
              ))
            ],
          ),
          DropdownButton(
            value: _selectedValue,
              items: Category.values.map((e) {
                return DropdownMenuItem(
                  value: e
                ,
                    child: Text(e.name.toUpperCase()));
              }).toList(),
              onChanged: (val) {
              if(val == null) {
                return;
              }
                setState(() {
                  _selectedValue = val;
                });
              }),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    if(username.text.trim().isEmpty ||
                    amount.text.trim().isEmpty ||
                    double.tryParse(amount.text)! < 0) {
                      showDialog(context: context, builder: (ctx) {
                        return AlertDialog(
                          title: const Text("Invalid data"),
                          content: const Text("There's a missing data"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text("Close"))
                          ],
                        );
                      });
                    } else {
                      widget.onAddExpense(Expense(title: username.text, amount: double.tryParse(amount.text)!, category: _selectedValue, date: _selectedDate!));
                      Navigator.pop(context);
                      // print(username.text);
                      // print(amount.text);
                      // print(_selectedValue);
                    }
                  },
                  child: const Text("Submit")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          )
        ],
      ),
    );
  }
}
