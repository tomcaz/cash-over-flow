import 'package:daily_cash_flow/widgets/balance_widget.dart';
import 'package:daily_cash_flow/widgets/label_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final MaterialColor primary = Colors.deepPurple;
  final Color secondary = Colors.white;

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
              labelMedium: const TextStyle(color: Colors.black54),
              titleMedium: TextStyle(fontSize: 15, color: primary.shade700)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: primary)
              .copyWith(secondary: secondary, error: Colors.red.shade400)),
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
            style: Theme.of(context).textTheme.titleMedium,
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
            const LabelWidget(label: "Last month"),
            _buildOB(3500.00, 2000.00),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.deepPurple),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              _buildNavIcon(Icons.dashboard, "Dashboard", _selectedIndex == 0),
              _buildNavIcon(Icons.input, "Income", _selectedIndex == 1),
              _buildNavIcon(Icons.output_sharp, "Spend", _selectedIndex == 2),
              _buildNavIcon(
                  Icons.monitor_heart_outlined, "Charts", _selectedIndex == 3),
            ],
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            selectedItemColor:
                Theme.of(context).colorScheme.secondary.withAlpha(255),
            onTap: _onItemTapped,
          ),
        ));
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

  Widget _buildIncomeOutgoing(double cash, bool isInbound) {
    Color color = isInbound
        ? Theme.of(context).primaryColor
        : Theme.of(context).colorScheme.error;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.black12),
          child: Expanded(
            child: Icon(
              isInbound ? Icons.input : Icons.output,
              color: color,
            ),
          ),
        ),
      )
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
