import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {

  static const String _keyLanguage1 = 'language1';
  static const String _keyLanguage2 = 'language2';

  static Future<String> getLanguage1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage1) ?? 'en';
  }

  static Future<void> setLanguage1(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage1, language);
  }

  static Future<String> getLanguage2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage2) ?? 'en';
  }

  static Future<void> setLanguage2(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage2, language);
  }
}
