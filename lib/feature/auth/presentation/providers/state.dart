import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.unauthenticated(String message) = UnAuthenticated;
  const factory AuthState.authenticated() = Authenticated;
}
