// data/remote/auth_remote_data_source.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/endpoints.dart';
import '../../../../core/network/network.dart';
import '../dto/login_dto.dart';
import '../dto/sign_up_dto.dart';
import '../model/auth_session.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSession> login(LoginDto dto);
  Future<AuthSession> signUp(SignUpDto dto);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkRequest networkRequest;
  final NetworkRetry networkRetry;

  AuthRemoteDataSourceImpl({
    required this.networkRequest,
    required this.networkRetry,
  });

  @override
  Future<AuthSession> login(LoginDto dto) async {
    final response = await networkRetry.networkRetry(
      () => networkRequest.post(Endpoints.login, body: dto.toJson()),
    );

    final data = response.data;

    // [A, D, B, B, A, C, A, C, C, A, A, A, D, C, A]

    if (response.isSuccess) {
      return AuthSession.fromJson(data);
    } else {
      final errorMessage = data['message'] ?? 'Login failed';
      throw Exception(errorMessage);
    }
  }

  @override
  Future<AuthSession> signUp(SignUpDto dto) async {
    final response = await networkRetry.networkRetry(
      () => networkRequest.post(Endpoints.signUp, body: dto.toJson()),
    );

    final data = response.data;

    if (response.isSuccess) {
      return AuthSession.fromJson(data);
    } else {
      final errorMessage = data['message'] ?? 'Sign up failed';
      throw Exception(errorMessage);
    }
  }
}

final authRemoteSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(
    networkRequest: ref.read(networkRequestProvider),
    networkRetry: ref.read(networkRetryProvider),
  ),
);
