import 'package:fluent_flow/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluent_flow/widgets/bottom_navigation_bar.dart';
import 'package:fluent_flow/widgets/translation_input.dart';
import 'package:fluent_flow/services/translation_service.dart';
import 'package:fluent_flow/utils/translations.dart';

import '../models/translation.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: buildTitle(),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Flexible(child: TranslationInput()),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() => TitleWidget(
        language1: language1,
        language2: language2,
        onChangedLanguage1: (newLanguage) => setState(() {
          language1 = newLanguage!;
        }),

        onChangedLanguage2: (newLanguage) => setState(() {
          language2 = newLanguage!;
        }),
      );
}
