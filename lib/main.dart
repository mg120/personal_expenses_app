import 'package:flutter/material.dart';
import 'package:personalexpensesapp/widgets/chart.dart';
import 'package:personalexpensesapp/widgets/new_transaction.dart';
import 'package:personalexpensesapp/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
            title: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo"),
          ),
        ),
        textTheme: ThemeData
            .light()
            .textTheme
            .copyWith(
          title: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo"),
          button: TextStyle(color: Colors.white,),
        ),

//        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((element) {
      element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Column(
          children: <Widget>[
            Chart(_userTransactions),
            Expanded(child: TransactionList(_userTransactions, _deleteTransaction))
          ],
        ),
      ),
    );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  void _deleteTransaction(int index) {
    setState(() {
//      _userTransactions.removeWhere((tx) => tx.id == id);
      _userTransactions.removeAt(index);
    });
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }
}
