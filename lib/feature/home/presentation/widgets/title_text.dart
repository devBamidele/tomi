import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        height: 1.4,
        letterSpacing: 0.2,
      ),
    );
  }
}
