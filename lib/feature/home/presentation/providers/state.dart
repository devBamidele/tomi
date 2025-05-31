import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/evaluation_result.dart';

part 'state.freezed.dart';

@freezed
class CourseEvaluationState with _$CourseEvaluationState {
  const factory CourseEvaluationState.initial() = Initial;
  const factory CourseEvaluationState.loading() = Loading;
  const factory CourseEvaluationState.error(String message) = EvaluationError;
  const factory CourseEvaluationState.loaded(EvaluationResult result) =
      EvaluationLoaded;
}
