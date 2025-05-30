import 'package:flutter/material.dart';

class VisibilityIcon extends StatelessWidget {
  const VisibilityIcon({
    super.key,
    required this.isVisible,
    required this.iconColor,
  });

  final bool isVisible;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isVisible ? Icons.visibility_off : Icons.visibility,
      color: iconColor,
      size: 20,
    );
  }
}
