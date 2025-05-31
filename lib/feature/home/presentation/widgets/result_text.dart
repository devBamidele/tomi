import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class ResultText extends StatelessWidget {
  const ResultText({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: 20,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              height: 1.4,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: 20,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
              height: 1.4,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
