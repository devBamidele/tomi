import 'package:auto_route/annotations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tomi/common/style/component_style.dart';
import 'package:tomi/feature/auth/application/auth_manager.dart';
import 'package:tomi/feature/home/presentation/extras.dart';
import 'package:tomi/feature/home/presentation/providers/state.dart';
import 'package:tomi/feature/home/presentation/screens/results.dart';

import '../../../../common/components/components.dart';
import '../../data/dto/evaluate_course.dart';
import '../providers/notifier.dart';
import '../widgets/calculate_button.dart';
import '../widgets/course_title_input.dart';
import '../widgets/field_of_study_dropdown.dart';
import '../widgets/title_text.dart';
import '../widgets/upload_section.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseTitle = useState('');
    final courseTitleFormKey = useMemoized(() => GlobalKey<FormState>());
    final courseTitleShakeKey = useMemoized(() => GlobalKey<ShakeState>());
    final selectedLevel = useState<String?>(null);

    final syllabusFile = useState<PlatformFile?>(null);
    final contentFile = useState<PlatformFile?>(null);

    ref.listen(courseEvaluationNotifierProvider, (prev, next) {
      if (next is EvaluationError) {
        showToast(next.message, context, isError: true);
      } else if (next is EvaluationLoaded) {
        showResultsSheet(context, next.result);
      }
    });

    void onCalculatePressed() async {
      if (courseTitleFormKey.currentState?.validate() != true) {
        courseTitleShakeKey.currentState?.shake();
        return;
      }
      if (syllabusFile.value == null || contentFile.value == null) {
        showToast(
          'Please upload both syllabus and content files',
          context,
          isError: true,
        );
        return;
      }
      if (selectedLevel.value == null) {
        showToast('Please select a field of study', context, isError: true);
        return;
      }

      final syllabus = await syllabusFile.value!.toFile();
      final content = await contentFile.value!.toFile();

      if (!context.mounted) return;

      if (syllabus == null || content == null) {
        showToast(
          'Error processing files. Please try again.',
          context,
          isError: true,
        );
        return;
      }

      final dto = EvaluateCourseDto(
        syllabus: syllabus,
        content: content,
        domain: selectedLevel.value!,
      );

      ref.read(courseEvaluationNotifierProvider.notifier).evaluateCourse(dto);
    }

    bool isLoading() => ref.watch(courseEvaluationNotifierProvider) is Loading;

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
                  TitleText('Hello ${AuthManager.instance.userName} 👋🏽'),
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
                    onPressed: onCalculatePressed,
                    isLoading: isLoading(),
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
