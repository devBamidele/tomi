import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../common/components/components.dart';
import '../../../auth/presentation/widgets/text_field_title.dart';

class CourseTitleInput extends HookWidget {
  final String initialValue;
  final void Function(String) onChanged;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ShakeState> shakeKey;

  const CourseTitleInput({
    required this.initialValue,
    required this.onChanged,
    required this.formKey,
    required this.shakeKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
    final focusNode = useFocusNode();
    final theme = Theme.of(context);

    useEffect(() {
      controller.addListener(() {
        onChanged(controller.text);
      });
      return null;
    }, [controller]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textFieldTitle('Course Title', theme),
        Form(
          key: formKey,
          child: Shake(
            key: shakeKey,
            child: AppTextField(
              enabled: true,
              focusNode: focusNode,
              textController: controller,
              hintText: 'e.g. Introduction to Computer Science',
              validation: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Course title is required';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
