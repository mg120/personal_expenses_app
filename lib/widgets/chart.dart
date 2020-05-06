import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalexpensesapp/models/transaction.dart';
import 'package:personalexpensesapp/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactionsList;

  Chart(this.recentTransactionsList);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // to get last seven days start from today so we used index
      var weekDay = DateTime.now().subtract(Duration(days: index));
      print("WeekDay $weekDay");
      var totalSum = 0.0;
      // compare last seven days date with list items date to get sum of that day
      for (int i = 0; i < recentTransactionsList.length; i++) {
        if (recentTransactionsList[i].date.day == weekDay.day &&
            recentTransactionsList[i].date.month == weekDay.month &&
            recentTransactionsList[i].date.year == weekDay.year) {
          totalSum += recentTransactionsList[i].amount;
          print("total Now $totalSum");
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues.map((element) {
              return Expanded(
                child: ChartBar(
                    element['day'],
                    element['amount'],
                    totalSpending == 0.0
                        ? 0.0
                        : (element['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ));
  }
}
