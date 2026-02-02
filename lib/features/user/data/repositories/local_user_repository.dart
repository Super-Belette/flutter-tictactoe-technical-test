import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class LocalUserRepository implements UserRepository {
  final SharedPreferences _prefs;
  static const _userKey = 'user_data';

  LocalUserRepository(this._prefs);

  @override
  Future<User?> getUser() async {
    final jsonString = _prefs.getString(_userKey);
    if (jsonString == null) return null;

    try {
      return User.fromJson(jsonDecode(jsonString));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveUser(User user) async {
    final jsonString = jsonEncode(user.toJson());
    await _prefs.setString(_userKey, jsonString);
  }

  @override
  Future<void> deleteUser() async {
    await _prefs.remove(_userKey);
  }
}
