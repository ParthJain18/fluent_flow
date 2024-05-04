import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/conversationHistory.dart';
import '../models/message.dart';

class PreferenceUtil {

  static const String _keyLanguage1 = 'language1';
  static const String _keyLanguage2 = 'language2';
  static const String _keyConversationHistory = 'conversationHistory';

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
}
