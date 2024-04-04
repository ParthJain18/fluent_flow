//write an empty page with text in the middle

import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Translation')),
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}