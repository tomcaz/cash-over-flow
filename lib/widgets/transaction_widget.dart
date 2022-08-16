import 'package:daily_cash_flow/widgets/money_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Transaction> transactions = [
  Transaction(Type.income, 2500.00, "03/11/2022 11:12 AM", "Salary"),
  Transaction(Type.expense, 513.10, "03/12/2022 9:00 AM", "Monitor Purchase"),
  Transaction(Type.expense, 12.16, "03/13/2022 1:12 PM", "Lunch"),
  Transaction(Type.expense, 14.30, "03/13/2022 5:12 PM", "Dinner"),
  Transaction(Type.expense, 501.10, "03/15/2022 11:12 AM", "Table"),
  Transaction(Type.income, 2500.00, "03/19/2022 10:12 AM", "Salary"),
  Transaction(Type.income, 2500.00, "03/11/2022 11:12 AM", "Salary"),
  Transaction(Type.expense, 513.10, "03/12/2022 9:00 AM", "Monitor Purchase"),
  Transaction(Type.expense, 12.16, "03/13/2022 1:12 PM", "Lunch"),
  Transaction(Type.expense, 14.30, "03/13/2022 5:12 PM", "Dinner"),
  Transaction(Type.expense, 501.10, "03/15/2022 11:12 AM", "Table"),
  Transaction(Type.income, 2500.00, "03/19/2022 10:12 AM", "Salary"),
];

enum Type { income, expense, all }

class TransactionWidget extends StatelessWidget {
  final Type type;
  TransactionWidget({Key? key, required this.type}) : super(key: key);
  late final List<Transaction> t = type == Type.all
      ? transactions
      : transactions.where((element) => element.type == type).toList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: t.length,
        itemBuilder: (BuildContext context, int index) {
          return TransactionListWidget(transaction: t[index]);
        });
  }
}

class Transaction {
  Type type;
  double amount;
  String date;
  String description;

  Transaction(this.type, this.amount, this.date, this.description);

  DateTime getDate() {
    return DateFormat.yMd().add_jm().parse(date);
  }

  String formatedDay() {
    return DateFormat.yMMMMd().format(getDate());
  }
}

class TransactionListWidget extends StatelessWidget {
  final Transaction transaction;
  const TransactionListWidget({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isIncome = transaction.type == Type.income;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: isIncome
                      ? Theme.of(context).primaryColor.withAlpha(40)
                      : Theme.of(context).colorScheme.error.withAlpha(40)),
              child: Icon(isIncome ? Icons.input : Icons.output,
                  size: 18,
                  color: isIncome
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.error),
            ),
          ),
        ),
        _buildWidget(transaction.description, transaction.formatedDay()),
        MoneyWidget(isIncome: isIncome, amount: transaction.amount),
      ]),
    );
  }

  Widget _buildWidget(String title, String subTitle) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black54),
          ),
          Text(
            subTitle,
            style: const TextStyle(
                fontSize: 11,
                color: Colors.black26,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700),
          ),
        ]),
      ),
    );
  }
}
