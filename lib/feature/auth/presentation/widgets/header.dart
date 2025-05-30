import 'package:flutter/material.dart';

import '../../../../common/components/components.dart';
import '../../../../core/constants/colors.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    required this.subtitle,
    this.topSpacing = 60,
    this.gapSpacing = 4,
    this.bottomSpacing = 36,
  });

  final String title;
  final String subtitle;
  final double topSpacing;
  final double gapSpacing;
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        addHeight(topSpacing),
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            height: 1.4,
            letterSpacing: 0.2,
          ),
        ),
        addHeight(gapSpacing),
        Text(
          subtitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: 16.5,
            color: AppColors.hintTextColor,
            height: 1.4,
            letterSpacing: 0.5,
          ),
        ),
        addHeight(bottomSpacing),
      ],
    );
  }
}
