import 'package:flutter/cupertino.dart';
import 'package:fluent_flow/models/message.dart';

class TranslationInputState with ChangeNotifier {
  final List<Message> _messages = [];
  final List<String> _suggestions = [];
  bool _isMe = true;

  List<Message> get messages => _messages;
  List<String> get suggestions => _suggestions;
  bool get isMe => _isMe;

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void clearSuggestions() {
    _suggestions.clear();
    notifyListeners();
  }

  void addSuggestion(String suggestion) {
    _suggestions.add(suggestion);
    notifyListeners();
  }

  void swapIsMe() {
    _isMe = !_isMe;
    notifyListeners();
  }
}