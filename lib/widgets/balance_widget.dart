import 'package:flutter/material.dart';
import 'dart:math' as math;

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);
  final int bal = 2000;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: const GradientRotation(math.pi / 4),
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withAlpha(120),
            ],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    "My Balance",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 10),
                  ),
                ),
                Text(
                  "\$ $bal",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  print("hello");
                },
                child: const Icon(Icons.add))
          ]),
        ),
      ),
    );
  }
}
