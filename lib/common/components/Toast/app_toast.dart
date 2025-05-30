import 'package:flutter/material.dart';

class CustomToast {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context,
    String message, {
    bool isError = false,
    SnackBarAction? action,
    Duration? duration,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                isError ? Icons.warning_rounded : Icons.check_circle_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                message,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
        action: action,
        backgroundColor: const Color(0xFF3D3D3D),
        behavior: SnackBarBehavior.fixed,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        elevation: 0,
        duration: duration ?? const Duration(milliseconds: 1500),
      ),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showToast(
  String message,
  BuildContext context, {
  bool isError = false,
  SnackBarAction? action,
  Duration? duration,
}) {
  return CustomToast.show(
    context,
    message,
    isError: isError,
    action: action,
    duration: duration,
  );
}
