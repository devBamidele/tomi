import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class ResultText extends StatelessWidget {
  const ResultText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$text : ',
        style: theme.textTheme.headlineSmall?.copyWith(
          fontSize: 20,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          height: 1.4,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
