import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';

Widget textFieldTitle(
  String text,
  ThemeData theme, {
  double bottomPadding = 2,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottomPadding.h),
    child: Text(
      text,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.5,
      ),
    ),
  );
}
