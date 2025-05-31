import 'package:flutter/material.dart';

import '../data/datasource/local.dart';
import '../data/model/auth_session.dart';
import '../data/model/user.dart';

class AuthManager {
  static final instance = AuthManager._();
  final _localSource = AuthLocalDataSourceImpl();

  User? user;
  AuthSession? _session;

  AuthManager._() {
    init();
  }

  Future<void> init() async {
    _session = await _localSource.getAuthSession();
    user = _session?.user;
  }

  Future<void> saveAuthSession(AuthSession session) async {
    _session = await _localSource.saveAuthSession(session);
    user = _session?.user;

    // Log results
    debugPrint('Saved session: ${_session.toString()}');
  }

  String? get accessToken => _session?.accessToken;
  bool get isLoggedIn => _session?.accessToken != null;
  String get userName => _session?.user?.name ?? '';
}
