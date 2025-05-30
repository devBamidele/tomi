import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.focusNode,
    required this.textController,
    required this.hintText,
    this.validation,
    this.suffixIcon,
    this.obscureText = false,
    this.error = false,
    this.action = TextInputAction.next,
    this.onFieldSubmitted,
    this.maxLength,
    this.lengthLimit,
    this.prefixIcon,
    this.enabled = true,
    this.keyboardType,
    this.padding = 16,
    this.maxLines = 1,
  });

  final FocusNode focusNode;
  final TextEditingController textController;
  final void Function(String)? onFieldSubmitted;
  final String hintText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validation;
  final TextInputAction action;
  final bool obscureText;

  final Color textColor = AppColors.black;
  final int? maxLength;
  final int? lengthLimit;
  final bool enabled;
  final bool error;
  final double padding;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color effectiveTextColor = enabled
        ? textColor
        : textColor.withValues(alpha: .7);

    return TextFormField(
      keyboardType: keyboardType,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontSize: 16,
        color: effectiveTextColor,
        letterSpacing: 0.7,
      ),
      maxLength: maxLength,
      cursorColor: textColor,
      focusNode: focusNode,
      controller: textController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      textInputAction: action,
      validator: validation,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      maxLines: maxLines,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength ?? lengthLimit),
      ],
      decoration: InputDecoration(
        hintStyle: theme.textTheme.headlineSmall?.copyWith(
          fontSize: 16,
          color: AppColors.hintTextColor,
          letterSpacing: 0.7,
        ),
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          vertical: padding,
          horizontal: padding / 2,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
