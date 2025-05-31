// features/course_evaluation/data/repository/course_repository.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/error_strings.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/network/network.dart';
import '../../../../core/runner/service_runner.dart';
import '../datasource/remote.dart';
import '../dto/evaluate_course.dart';
import '../model/evaluation_result.dart';

abstract class CourseRepository {
  Future<Either<Failure, EvaluationResult>> evaluateCourse(
    EvaluateCourseDto dto,
  );
}

class CourseRepositoryImpl implements CourseRepository {
  final NetworkInfo _networkInfo;
  final EvaluateRemoteDataSource _remoteDataSource;

  CourseRepositoryImpl(Ref ref)
    : _remoteDataSource = ref.read(evaluateRemoteSourceProvider),
      _networkInfo = ref.read(networkInfoProvider);

  @override
  Future<Either<Failure, EvaluationResult>> evaluateCourse(
    EvaluateCourseDto dto,
  ) async {
    final sR = ServiceRunner<Failure, EvaluationResult>(_networkInfo);
    return sR.tryRemoteAndCatch(
      call: _remoteDataSource.evaluateCourse(dto),
      errorTitle: ErrorStrings.EVALUATION_ERROR,
    );
  }
}

final courseRepositoryProvider = Provider<CourseRepository>(
  (ref) => CourseRepositoryImpl(ref),
);
