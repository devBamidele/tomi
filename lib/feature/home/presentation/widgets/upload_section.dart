import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../common/components/components.dart';
import '../../../../core/constants/colors.dart';
import 'dotted_upload_box.dart';

class UploadSection extends HookWidget {
  final String label;
  final void Function(PlatformFile?) onFileSelected;

  const UploadSection({
    required this.label,
    required this.onFileSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedFile = useState<PlatformFile?>(null);
    final theme = Theme.of(context);

    Future<void> pickPdfFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true, // if you want file bytes
      );
      if (result != null && result.files.isNotEmpty) {
        selectedFile.value = result.files.first;
        onFileSelected(selectedFile.value);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            height: 1.4,
            letterSpacing: 0.5,
          ),
        ),
        addHeight(16),
        GestureDetector(
          onTap: pickPdfFile,
          child: DottedUploadBox(
            label: selectedFile.value?.name ?? 'Upload PDF file',
          ),
        ),
      ],
    );
  }
}
