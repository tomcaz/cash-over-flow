import 'package:daily_cash_flow/widgets/balance_widget.dart';
import 'package:daily_cash_flow/widgets/label_widget.dart';
import 'package:daily_cash_flow/widgets/money_widget.dart';
import 'package:daily_cash_flow/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final MaterialColor primary = Colors.deepPurple;
  final Color secondary = Colors.white;
  final Color error = Colors.red.shade400;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash Overflow',
      theme: ThemeData(
          primaryColor: primary,
          useMaterial3: true,
          fontFamily: "dunkin",
          appBarTheme:
              AppBarTheme(actionsIconTheme: IconThemeData(color: primary)),
          textTheme: TextTheme(
              headline2: TextStyle(color: primary, fontSize: 15),
              headline3: TextStyle(color: error, fontSize: 15),
              headline4: const TextStyle(color: Colors.black26, fontSize: 10),
              headline5: const TextStyle(color: Colors.black54, fontSize: 14),
              headline6: TextStyle(fontSize: 15, color: primary.shade700)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: primary)
              .copyWith(secondary: secondary, error: error)),
      home: const MyHomePage(title: 'Cash Overflow'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                child: const Icon(Icons.account_circle_rounded),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            const Balance(),
            const LabelWidget(label: "Last month", style: Size.medium),
            _buildOB(3500.00, 2000.00),
            const LabelWidget(label: "Transactions", style: Size.medium),
            Expanded(
                child: TransactionWidget(
              type: Type.all,
            ))
          ],
        ),
        bottomNavigationBar: _buildBottomNav());
  }

  BottomNavigationBarItem _buildNavIcon(
      IconData icon, String tooltip, bool selected) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: Theme.of(context)
              .colorScheme
              .secondary
              .withAlpha(selected ? 255 : 100),
        ),
        label: ".",
        tooltip: tooltip);
  }

  Row _buildOB(double income, double outgoing) {
    return Row(
      children: [
        _buildIncomeOutgoing(income, true),
        _buildIncomeOutgoing(outgoing, false)
      ],
    );
  }

  Widget _buildIncomeOutgoing(double cash, bool isIncome) {
    Color color = isIncome
        ? Theme.of(context).primaryColor
        : Theme.of(context).colorScheme.error;
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black.withAlpha(8)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    isIncome ? Icons.input : Icons.output,
                    color: color,
                  ),
                ),
                LabelWidget(
                    label: isIncome ? "Income" : "Expenses", style: Size.small),
                const SizedBox(height: 15),
                MoneyWidget(
                  amount: cash,
                  isIncome: isIncome,
                )
              ],
            ),
          ),
        ));
  }

  Theme _buildBottomNav() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.deepPurple),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildNavIcon(Icons.dashboard, "Dashboard", _selectedIndex == 0),
          _buildNavIcon(Icons.input, "Income", _selectedIndex == 1),
          _buildNavIcon(Icons.output_sharp, "Expenses", _selectedIndex == 2),
          _buildNavIcon(
              Icons.monitor_heart_outlined, "Charts", _selectedIndex == 3),
        ],
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        selectedItemColor:
            Theme.of(context).colorScheme.secondary.withAlpha(255),
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
