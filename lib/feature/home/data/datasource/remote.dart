import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/endpoints.dart';
import '../../../../core/network/network.dart';
import '../dto/evaluate_course.dart';
import '../model/evaluation_result.dart';

abstract class EvaluateRemoteDataSource {
  Future<EvaluationResult> evaluateCourse(EvaluateCourseDto dto);
}

class EvaluateRemoteDataSourceImpl implements EvaluateRemoteDataSource {
  final NetworkRequest networkRequest;
  final NetworkRetry networkRetry;

  EvaluateRemoteDataSourceImpl({
    required this.networkRequest,
    required this.networkRetry,
  });

  @override
  Future<EvaluationResult> evaluateCourse(EvaluateCourseDto dto) async {
    final response = await networkRetry.networkRetry(
      () => networkRequest.postMultipart(
        Endpoints.evaluateCourse,
        files: dto.files,
        fields: dto.fields,
      ),
    );

    final data = response.data;

    if (response.isSuccess) {
      return EvaluationResult.fromJson(data);
    } else {
      final errorMessage = data['message'] ?? 'Evaluation failed';
      throw Exception(errorMessage);
    }
  }
}

final evaluateRemoteSourceProvider = Provider<EvaluateRemoteDataSource>(
  (ref) => EvaluateRemoteDataSourceImpl(
    networkRequest: ref.read(networkRequestProvider),
    networkRetry: ref.read(networkRetryProvider),
  ),
);
