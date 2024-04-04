import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageSelectionAppBar extends StatefulWidget implements PreferredSizeWidget {
  LanguageSelectionAppBar({super.key})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  _LanguageSelectionAppBarState createState() => _LanguageSelectionAppBarState();
}

class _LanguageSelectionAppBarState extends State<LanguageSelectionAppBar> {
  final List<String> _languages = ['English', 'Spanish', 'French', 'German', 'Italian', 'Chinese'];
  String _selectedLanguage1 = 'English';
  String _selectedLanguage2 = 'Spanish';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton<String>(
            value: _selectedLanguage1,
            items: _languages.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage1 = newValue!;
              });
            },
          ),
          const Icon(Icons.swap_horiz),
          DropdownButton<String>(
            value: _selectedLanguage2,
            items: _languages.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage2 = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}