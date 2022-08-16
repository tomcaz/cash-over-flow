import 'package:flutter/material.dart';

enum Size { small, medium, large }

class LabelWidget extends StatelessWidget {
  final String label;
  final Size style;
  const LabelWidget({Key? key, required this.label, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            label,
            style: style == Size.large
                ? Theme.of(context).textTheme.labelLarge
                : (style == Size.medium
                    ? Theme.of(context).textTheme.headline5
                    : Theme.of(context).textTheme.headline4),
          ),
        ),
      ],
    );
  }
}
