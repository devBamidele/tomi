import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/hive_constants.dart';
import '../model/auth_session.dart';
import '../model/user.dart';

abstract class AuthLocalDataSource {
  Future<AuthSession> saveAuthSession(AuthSession session);
  Future<AuthSession?> getAuthSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userBox = HiveConstants.userBox;
  static const String _userKey = HiveConstants.userKey;

  static const _accessTokenKey = SecureStorage.accessTokenKey;

  final _secureStorage = const FlutterSecureStorage();

  Future<Box<T?>> _openBox<T>({String boxName = _userBox}) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    } else {
      return await Hive.openBox<T>(boxName);
    }
  }

  @override
  Future<AuthSession?> getAuthSession() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);

    if (accessToken == null) return null;

    final userBox = await _openBox<User>();
    final user = userBox.get(_userKey);

    if (user == null) return null;

    return AuthSession(accessToken: accessToken, user: user);
  }

  @override
  Future<AuthSession> saveAuthSession(AuthSession session) async {
    await _secureStorage.write(
      key: _accessTokenKey,
      value: session.accessToken,
    );

    final userBox = await _openBox<User>();
    await userBox.put(_userKey, session.user);

    return session;
  }
}
