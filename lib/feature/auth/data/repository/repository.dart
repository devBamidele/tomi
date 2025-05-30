import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/error_strings.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/network/network.dart';
import '../../../../core/runner/service_runner.dart';
import '../datasource/remote.dart';
import '../dto/login_dto.dart';
import '../dto/sign_up_dto.dart';
import '../model/auth_session.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSession>> login(LoginDto dto);
  Future<Either<Failure, AuthSession>> signUp(SignUpDto dto);
}

class AuthRepositoryImpl implements AuthRepository {
  final NetworkInfo _networkInfo;
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(Ref ref)
    : _authRemoteDataSource = ref.read(authRemoteSourceProvider),
      _networkInfo = ref.read(networkInfoProvider);

  @override
  Future<Either<Failure, AuthSession>> login(LoginDto dto) async {
    final sR = ServiceRunner<Failure, AuthSession>(_networkInfo);
    return sR.tryRemoteAndCatch(
      call: _authRemoteDataSource.login(dto),
      errorTitle: ErrorStrings.LOGIN_ERROR,
    );
  }

  @override
  Future<Either<Failure, AuthSession>> signUp(SignUpDto dto) async {
    final sR = ServiceRunner<Failure, AuthSession>(_networkInfo);
    return sR.tryRemoteAndCatch(
      call: _authRemoteDataSource.signUp(dto),
      errorTitle: ErrorStrings.SIGN_UP_ERROR,
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref),
);
