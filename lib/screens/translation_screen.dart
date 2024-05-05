import 'package:fluent_flow/utils/preference_util.dart';
import 'package:flutter/material.dart';
import 'package:fluent_flow/widgets/TranslationChatInterface.dart';
import 'package:fluent_flow/utils/translations.dart';
import '../models/message.dart';
import '../widgets/title_widget.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  // final TranslationService _translationService = TranslationService();

  String language1 = Translations.languages.first;
  String language2 = Translations.languages.first;
  // String language1 = 'English';
  // String language2 = 'Hindi';

  @override
  void initState() {
    super.initState();
    PreferenceUtil.getLanguage1().then((value) => setState(() {
          language1 = value;
        }));
    PreferenceUtil.getLanguage2().then((value) => setState(() {
          language2 = value;
        }));
  }

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
            Flexible(
                child: TranslationChatInterface(
              messageList: messages,
            )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(void Function() resetMessages) => TitleWidget(
        language1: language1,
        language2: language2,
        onChangedLanguage1: (newLanguage) => {
          setState(() {
            language1 = newLanguage!;
          }),
          PreferenceUtil.setLanguage1(newLanguage ?? 'English')
        },
        onChangedLanguage2: (newLanguage) => {
          setState(() {
            language2 = newLanguage!;
          }),
          PreferenceUtil.setLanguage2(newLanguage ?? 'English')
        },
        saveConversation: () {
          print('Saving conversation');
          PreferenceUtil.saveHistory(messages);
          resetMessages();
        },
      );
}
