import 'package:auto_route/annotations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tomi/common/style/component_style.dart';

import '../../../../common/components/components.dart';
import '../widgets/calculate_button.dart';
import '../widgets/course_title_input.dart';
import '../widgets/field_of_study_dropdown.dart';
import '../widgets/title_text.dart';
import '../widgets/upload_section.dart';
import 'results.dart';

@RoutePage()
class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseTitle = useState('');
    final courseTitleFormKey = useMemoized(() => GlobalKey<FormState>());
    final courseTitleShakeKey = useMemoized(() => GlobalKey<ShakeState>());
    final selectedLevel = useState<String?>(null);

    final syllabusFile = useState<PlatformFile?>(null);
    final contentFile = useState<PlatformFile?>(null);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  addHeight(30),
                  const TitleText('Hello Tomi 👋🏽'),
                  addHeight(50),

                  CourseTitleInput(
                    initialValue: courseTitle.value,
                    formKey: courseTitleFormKey,
                    shakeKey: courseTitleShakeKey,
                    onChanged: (val) => courseTitle.value = val,
                  ),
                  addHeight(30),

                  FieldOfStudyDropdown(
                    selectedValue: selectedLevel.value,
                    onChanged: (val) => selectedLevel.value = val,
                  ),
                  addHeight(30),

                  UploadSection(
                    label: 'Upload Course Syllabus',
                    onFileSelected: (file) => syllabusFile.value = file,
                  ),
                  addHeight(40),

                  UploadSection(
                    label: 'Upload Course Content',
                    onFileSelected: (file) => contentFile.value = file,
                  ),
                  addHeight(40),

                  CalculateButton(
                    onPressed: () => _showTaskBottomSheet(context),
                    isLoading: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showTaskBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ResultsSheet(),
  );
}
