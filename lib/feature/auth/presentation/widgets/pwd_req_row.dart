import 'package:flutter/material.dart';

import '../../../../common/components/components.dart';
import '../../../../core/constants/colors.dart';

class PasswordRequirementRow extends StatelessWidget {
  final String text;
  final bool checked;
  final TextTheme theme;

  const PasswordRequirementRow({
    super.key,
    required this.text,
    required this.checked,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check,
          color: checked ? Colors.green.shade300 : AppColors.hintTextColor,
          size: 17,
        ),
        addWidth(8),
        Expanded(
          child: Text(
            text,
            style: theme.headlineSmall?.copyWith(
              fontSize: 16,
              color: checked ? Colors.green.shade300 : AppColors.hintTextColor,
              height: 1.4,
              letterSpacing: 0.5,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
