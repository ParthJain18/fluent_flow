import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  static const String _keyLanguage = 'language';

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage) ?? 'en';
  }

  static Future<void> setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, language);
  }
}