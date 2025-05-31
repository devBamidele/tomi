// data/dto/evaluate_course_dto.dart

import 'dart:io';

class EvaluateCourseDto {
  final File syllabus;
  final File content;
  final String domain;

  EvaluateCourseDto({
    required this.syllabus,
    required this.content,
    required this.domain,
  });

  Map<String, String> get fields => {'domain': domain};

  Map<String, File> get files => {'syllabus': syllabus, 'content': content};
}
