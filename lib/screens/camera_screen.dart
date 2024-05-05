import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  bool _isShutterClicked = false;
  String _translatedText = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await _cameraController.initialize();
    await _cameraController.setFlashMode(FlashMode.off);

    setState(() {});
  }

  Future<void> _takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return;
    }

    setState(() {
      _isShutterClicked = true;
    });

    XFile picture = await _cameraController.takePicture();

    File imageFile = File(picture.path);

    print(imageFile);

    setState(() {
      _isShutterClicked = false;
    });

    // REMAINING LOGIC


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_cameraController.value.isInitialized)
            CameraPreview(_cameraController),
          if (_isShutterClicked)
            const Center(child: CircularProgressIndicator()),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              icon: const Icon(Icons.camera),
              onPressed: _takePicture,
            ),
          ),
          if (_translatedText.isNotEmpty)
            Positioned(
              bottom: 100,
              left: 100,
              child: Container(
                width: 200,
                height: 100,
                color: Colors.white,
                child: Text(_translatedText),
              ),
            ),
        ],
      ),
    );
  }
}