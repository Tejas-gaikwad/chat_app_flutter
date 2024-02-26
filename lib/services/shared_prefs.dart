import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<bool> getUserLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> setUserLoginStatus({required bool status}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', status);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('userId');
    return uid;
  }

  static Future<void> setUserId({required String userId}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
  }
}
