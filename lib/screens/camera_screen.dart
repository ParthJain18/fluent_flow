import 'package:flutter/material.dart';


class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Translation')),
      body: const Center(
        child: Text('Camera Screen'),
      ),
    );
  }
}