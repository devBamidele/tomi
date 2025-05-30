// common/components/dotted_upload_box.dart

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tomi/common/components/Box/box.dart';

class DottedUploadBox extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;

  const DottedUploadBox({super.key, this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: DottedDecoration(
          color: Colors.grey,
          strokeWidth: 1.5,
          dash: [6, 4],
          shape: Shape.box,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.upload_file_outlined,
                size: 34,
                color: Colors.grey,
              ),
              addHeight(6),
              Text(
                label ?? 'Tap to upload',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 15.5,
                  height: 1.4,
                  letterSpacing: 0.6,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
