import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.dummyData, this.onRemoveExpense,{super.key});

  final List<Expense> dummyData;
  final void Function(Expense exp) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: dummyData.length,itemBuilder: (ctx, idx) {
      return Dismissible(key: ValueKey(dummyData[idx]),
          onDismissed: (dir) {
            onRemoveExpense(dummyData[idx]);
          },
          child: Column(
        children: [
          Text(dummyData[idx].title),
          const SizedBox(height: 40,),
          Row(
            children: [
              Text(dummyData[idx].amount.toStringAsFixed(2)),
              const Spacer(),
              Row(
                children: [
                  Icon(iconsFromCategory[dummyData[idx].category]),
                  const SizedBox(width: 10,),
                  Text(dummyData[idx].formattedDate)
                ],
              )
            ],
          )
        ],
      ));
    });
  }

}