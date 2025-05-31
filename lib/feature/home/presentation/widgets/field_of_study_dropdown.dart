import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../auth/presentation/widgets/text_field_title.dart';

class FieldOfStudyDropdown extends HookWidget {
  final String? selectedValue;
  final void Function(String?) onChanged;
  final List<String> items;

  const FieldOfStudyDropdown({
    this.selectedValue,
    required this.onChanged,
    this.items = const [
      'Science',
      'Medicine',
      'Finance',
      'Engineering',
      'Others',
    ],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textFieldTitle('Field of study', theme),
        DropdownButtonHideUnderline(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.black.withValues(alpha: .55),
                  width: 1,
                ),
              ),
            ),
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select field of study',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  letterSpacing: 0.7,
                ),
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 16,
                          color: AppColors.black,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: selectedValue,
              onChanged: onChanged,
              dropdownStyleData: DropdownStyleData(
                elevation: 2,
                decoration: BoxDecoration(
                  color: AppColors.whiteShade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
