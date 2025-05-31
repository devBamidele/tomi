import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:tomi/common/components/Box/box.dart';
import 'package:tomi/feature/home/data/model/evaluation_result.dart';
import 'package:tomi/feature/home/presentation/widgets/result_text.dart';

class ResultsSheet extends HookWidget {
  const ResultsSheet({super.key, required this.result});

  final EvaluationResult result;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        constraints: BoxConstraints(
          maxWidth: 0.9.sw,
          minHeight: 0.1.sh,
          maxHeight: 0.62.sh,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.w),
              child: Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 32.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCA0F8),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.task_square,
                          size: 16.sp,
                          color: const Color(0xFF3D3D3D),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          ' Results',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Iconsax.close_circle,
                        size: 20.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: Colors.grey[200]),

            addHeight(12),
            ResultText(
              label: 'Relevance',
              value: result.relevanceScore.toStringAsFixed(2),
            ),
            ResultText(
              label: 'Readability',
              value: result.readabilityScore.toStringAsFixed(2),
            ),
            ResultText(
              label: 'Lexical Diversity',
              value: result.lexicalDiversityScore.toStringAsFixed(2),
            ),
            ResultText(
              label: 'Quality Score',
              value: result.overallQualityScore.toStringAsFixed(2),
            ),
            addHeight(20),
          ],
        ),
      ),
    );
  }
}

void showResultsSheet(BuildContext context, EvaluationResult result) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ResultsSheet(result: result),
  );
}
