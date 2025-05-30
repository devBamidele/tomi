import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../failures/failures.dart';
import '../network/network_info.dart';

class ServiceRunner<F extends Failure, T> {
  final NetworkInfo networkInfo;

  ServiceRunner(this.networkInfo);

  Future<Either<F, T>> tryRemoteAndCatch({
    required Future<T> call,
    required String errorTitle,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(InternetFailure(errorTitle, 'No internet access') as F);
    }

    try {
      final result = await call;
      return Right(result);
    } on DioException catch (e) {
      return Left(_handleDioError(e, errorTitle) as F);
    } on FormatException catch (e) {
      return Left(CommonFailure(errorTitle, e.message) as F);
    } catch (e) {
      return Left(CommonFailure(errorTitle, _formatException(e)) as F);
    }
  }

  Failure _handleDioError(DioException e, String title) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    if (e.type == DioExceptionType.badResponse && statusCode == 400) {
      final message = data?['message'] ?? 'Unknown error';
      return AuthenticationFailure(title, '$message');
    }

    return ServerFailure(title, 'Unexpected server error: ${e.message}');
  }

  String _formatException(Object e) {
    return e.toString().replaceFirst('Exception: ', '').trim();
  }
}
