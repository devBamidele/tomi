import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../Loader/indicator.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final Color? color;
  final Color? labelColor;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
    this.color,
    this.labelColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = AppColors.primary;
    final textColor = Colors.white;
    final theme = Theme.of(context);

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 46.r,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return buttonColor.withValues(alpha: 0.85);
            }
            return buttonColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return textColor;
            }
            return textColor;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
        child: isLoading
            ? const LoadingIndicator(size: 30)
            : Text(
                text,

                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
