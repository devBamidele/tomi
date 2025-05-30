import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';

class TextStyles {
  static TextStyle base = const TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    letterSpacing: 0.4,
    height: 1.4,
  );

  static TextStyle heading({
    double fontSize = 32,
    FontWeight fontWeight = FontWeight.w700,
    Color? color,
  }) {
    return base.copyWith(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // AppTextField
  static TextStyle body({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return base.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: textDecoration,
      decorationThickness: 1.5,
      decorationColor: AppColors.black,
    );
  }

  static TextStyle action({
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
  }) {
    return base.copyWith(fontWeight: fontWeight, fontSize: fontSize.sp);
  }

  static TextStyle error({double fontSize = 14}) {
    return base.copyWith(
      fontSize: fontSize,
      color: AppColors.errorBorderColor.withValues(alpha: .8),
    );
  }

  static TextStyle snackbarText({
    FontWeight fontWeight = FontWeight.w500,
    Color color = Colors.white,
  }) {
    return base.copyWith(color: color, fontWeight: fontWeight, fontSize: 16);
  }
}
