import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageProvider = Provider<LocalStorage>((ref) {
  throw UnimplementedError('Initialize in main.dart');
});

class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  // Token
  Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    return _prefs.getString('token');
  }

  Future<void> clearToken() async {
    await _prefs.remove('token');
  }

  // User Role
  Future<void> saveRole(String role) async {
    await _prefs.setString('role', role);
  }

  String? getRole() {
    return _prefs.getString('role');
  }

  // User Data
  Future<void> saveUser(Map<String, dynamic> user) async {
    await _prefs.setString('user', user.toString());
  }

  // Clear All
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  bool get isLoggedIn => _prefs.getString('token') != null;
}
