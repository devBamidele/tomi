import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tomi/feature/auth/presentation/providers/state.dart';

import '../../data/dto/login_dto.dart';
import '../../data/dto/sign_up_dto.dart';
import '../../data/repository/repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(Ref ref)
    : _repository = ref.read(authRepositoryProvider),
      super(const AuthState.initial());

  Future<void> signup(SignUpDto dto) async {
    state = const AuthState.loading();

    final result = await _repository.signUp(dto);

    result.fold((l) => state = AuthState.unauthenticated(l.message), (r) async {
      state = AuthState.authenticated();
      //  await AuthManager.instance.saveAuthSession(r);
    });
  }

  Future<void> login(LoginDto dto) async {
    state = const AuthState.loading();

    final result = await _repository.login(dto);

    result.fold((l) => state = AuthState.unauthenticated(l.message), (r) async {
      state = AuthState.authenticated();

      // await AuthManager.instance.saveAuthSession(r);
    });
  }
}

final authNotifierProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(ref),
    );
