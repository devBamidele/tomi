import 'package:flutter/material.dart';

import '../../../../common/components/components.dart';

class CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const CalculateButton({
    required this.onPressed,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      text: 'Calculate Quality',
      isLoading: isLoading,
    );
  }
}
