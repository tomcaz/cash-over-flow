import 'package:daily_cash_flow/util/money_util.dart';
import 'package:flutter/material.dart';

class MoneyWidget extends StatelessWidget {
  final bool isIncome;
  final double amount;
  const MoneyWidget({Key? key, required this.isIncome, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "\$ ${MoneyUtril.format(amount)}",
            style: isIncome
                ? Theme.of(context).textTheme.headline2
                : Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
