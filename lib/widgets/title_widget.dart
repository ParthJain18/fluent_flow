import 'package:flutter/material.dart';

import '../utils/preference_util.dart';
import 'drop_down_widget.dart';

class TitleWidget extends StatelessWidget {
  final String language1;
  final String language2;
  final void Function(String?) onChangedLanguage1;
  final void Function(String?) onChangedLanguage2;

  const TitleWidget({
    required this.language1,
    required this.language2,
    required this.onChangedLanguage1,
    required this.onChangedLanguage2,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Spacer(),
      DropDownWidget(
        value: language1,
        onChangedLanguage: (String? newValue) {
          print(newValue);
          onChangedLanguage1(newValue);
          PreferenceUtil.setLanguage1(newValue ?? 'English');
        },
      ),
      const Spacer(),
      const Icon(Icons.translate, color: Colors.black87),
      const Spacer(),
      DropDownWidget(
        value: language2,
        onChangedLanguage: (String? newValue) {
          print(newValue);
          onChangedLanguage2(newValue);
          PreferenceUtil.setLanguage2(newValue ?? 'English');
        },
      ),
      const Spacer(),
    ],
  );
}