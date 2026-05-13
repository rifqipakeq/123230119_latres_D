import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyAccounts = 'accounts';
  static const String _keyCurrentUserId = 'current_user_id';
  static const String _keyCurrentUsername = 'current_username';
  static const String _keyIsLoggedIn = 'is_logged_in';

  static String toUserId(String username) =>
      username.trim().toLowerCase().replaceAll(' ', '_');

  static String _hashPassword(String password) => password;

  static Future<Map<String, String>> _loadAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyAccounts);
    if (raw == null) return {};
    return Map<String, String>.from(jsonDecode(raw));
  }

  static Future<void> _saveAccounts(Map<String, String> accounts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccounts, jsonEncode(accounts));
  }

  static Future<String?> register(String username, String password) async {
    if (username.trim().isEmpty) return 'Username tidak boleh kosong';
    if (password.isEmpty) return 'Password tidak boleh kosong';
    if (password.length < 4) return 'Password minimal 4 karakter';

    final userId = toUserId(username);
    final accounts = await _loadAccounts();

    if (accounts.containsKey(userId)) {
      return 'Username sudah terdaftar';
    }

    accounts[userId] = _hashPassword(password);
    await _saveAccounts(accounts);
    return null; // success
  }

  static Future<String?> login(String username, String password) async {
    if (username.trim().isEmpty) return 'Username tidak boleh kosong';
    if (password.isEmpty) return 'Password tidak boleh kosong';

    final userId = toUserId(username);
    final accounts = await _loadAccounts();

    if (!accounts.containsKey(userId)) return 'Akun tidak ditemukan';
    if (accounts[userId] != _hashPassword(password)) return 'Password salah';

    // Save session
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCurrentUserId, userId);
    await prefs.setString(_keyCurrentUsername, username.trim());
    await prefs.setBool(_keyIsLoggedIn, true);
    return null; // success
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCurrentUserId);
    await prefs.remove(_keyCurrentUsername);
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentUsername);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentUserId);
  }
}
