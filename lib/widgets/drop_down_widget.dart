import 'package:flutter/material.dart';
import 'package:fluent_flow/utils/translations.dart';

class DropDownWidget extends StatelessWidget {
  final String value;
  final void Function(String?) onChangedLanguage;

  const DropDownWidget({
    required this.value,
    required this.onChangedLanguage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = Translations.languages
        .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
        .toList();

    return DropdownButton<String>(
      value: value,
      icon: const Icon(Icons.expand_more, color: Colors.grey),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: onChangedLanguage,
      items: items,
    );
  }
}
