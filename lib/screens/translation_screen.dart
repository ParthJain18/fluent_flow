import 'package:fluent_flow/utils/preference_util.dart';
import 'package:fluent_flow/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluent_flow/widgets/TranslationChatInterface.dart';
import 'package:fluent_flow/utils/translations.dart';

import '../models/message.dart';
import '../models/translation.dart';
import '../utils/saveConversationHistory.dart';
import '../widgets/title_widget.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  // final TranslationService _translationService = TranslationService();
  Translation? _translation;

  String language1 = Translations.languages.first;
  String language2 = Translations.languages.first;

  List<Message> messages = [];

  void resetMessages() {
    setState(() {
      messages = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: buildTitle(resetMessages),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Flexible(child: ChatInterface()),
            Flexible(child: TranslationChatInterface(messageList: messages,)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(void Function() resetMessages) => TitleWidget(
        language1: language1,
        language2: language2,
        onChangedLanguage1: (newLanguage) => setState(() {
          language1 = newLanguage!;
        }),

        onChangedLanguage2: (newLanguage) => setState(() {
          language2 = newLanguage!;
        }),
        saveConversation: () {
          print('Saving conversation');
          PreferenceUtil.saveHistory(messages);
          resetMessages();
        },
      );
}
