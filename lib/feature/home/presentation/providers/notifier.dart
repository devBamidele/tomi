import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tomi/feature/home/presentation/providers/state.dart';

import '../../data/dto/evaluate_course.dart';
import '../../data/repository/repository.dart';

class CourseEvaluationNotifier extends StateNotifier<CourseEvaluationState> {
  final CourseRepository _repository;

  CourseEvaluationNotifier(Ref ref)
    : _repository = ref.read(courseRepositoryProvider),
      super(const CourseEvaluationState.initial());

  Future<void> evaluateCourse(EvaluateCourseDto dto) async {
    state = const CourseEvaluationState.loading();

    final result = await _repository.evaluateCourse(dto);

    result.fold(
      (failure) => state = CourseEvaluationState.error(failure.message),
      (evaluationResult) =>
          state = CourseEvaluationState.loaded(evaluationResult),
    );
  }
}

final courseEvaluationNotifierProvider =
    StateNotifierProvider.autoDispose<
      CourseEvaluationNotifier,
      CourseEvaluationState
    >((ref) => CourseEvaluationNotifier(ref));
