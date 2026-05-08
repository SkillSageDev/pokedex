import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefs{
  static const _usernameKey = "username";
  static const _emailKey = "email";
  static const _pass = "password";

  static Future<void> saveUser({
    required String username,
    required String email,
    String? password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_emailKey, email);
    if (password != null) {
      await prefs.setString(_pass, password);
    }
  }

  static Future<String?> getEmail() async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }
}
