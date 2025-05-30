// Rename to avoid confusion with actual user model
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/constants/hive_constants.dart';
import 'user.dart';

part 'auth_session.g.dart';

@HiveType(typeId: HiveConstants.authSessionHiveId)
@JsonSerializable()
class AuthSession {
  @HiveField(0)
  @JsonKey(name: 'accessToken')
  final String? accessToken;

  @HiveField(1)
  @JsonKey(name: 'user')
  final User? user;

  AuthSession({this.accessToken, this.user});

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSessionToJson(this);

  AuthSession copyWith({String? accessToken, User? user}) {
    return AuthSession(
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return '''AuthSession(
  accessToken: $accessToken, 
  user: $user
)''';
  }
}
