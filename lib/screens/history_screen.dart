//write an empty page with text in the middle

import 'package:flutter/material.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Translation')),
      body: const Center(
        child: Text('History Screen'),
      ),
    );
  }
}