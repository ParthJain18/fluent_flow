import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/message.dart';

class PreferenceUtil {
  static const String _keyLanguage1 = 'language1';
  static const String _keyLanguage2 = 'language2';
  static const String _keyConversationHistory = 'conversationHistory';
  static const String _imageLanguage = 'imageLanguage';
  static const String _userLanguage = 'userLanguage';

  static Future<String> getLanguage1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage1) ?? 'English';
  }

  static Future<void> setLanguage1(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage1, language);
  }

  static Future<String> getLanguage2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage2) ?? 'English';
  }

  static Future<void> setLanguage2(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage2, language);
  }

  static Future<void> saveHistory(List<Message> messages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve and decode the existing conversation histories
    String? jsonString = prefs.getString(_keyConversationHistory);
    List<List<Map<String, dynamic>>> histories = jsonString != null
        ? (jsonDecode(jsonString) as List)
            .map((history) => (history as List)
                .map((message) => message as Map<String, dynamic>)
                .toList())
            .toList()
        : [];

    // Add the new conversation history
    histories.add(messages.map((m) => m.toJson()).toList());

    print('Histories: $histories');

    // Save the updated conversation histories
    jsonString = jsonEncode(histories);
    await prefs.setString(_keyConversationHistory, jsonString);
  }

  static Future<List<List<Object>>> getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve and decode the existing conversation histories
    String? jsonString = prefs.getString(_keyConversationHistory);
    List<List<Object>> histories = jsonString != null
        ? (jsonDecode(jsonString) as List)
            .map((history) => (history as List)
                .map((message) =>
                    Message.fromJson(message as Map<String, dynamic>))
                .toList())
            .toList()
        : [];

    return histories;
  }

  static Future<String> getUserLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userLanguage) ?? 'English';
  }

  static Future<void> setUserLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userLanguage, language);
  }

  static Future<String> getImageLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_imageLanguage) ?? 'English';
  }

  static Future<void> setImageLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imageLanguage, language);
  }
}
