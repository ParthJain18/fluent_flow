import 'dart:convert';
import 'dart:io';
import '../config.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../widgets/title_widget.dart';
import '../utils/preference_util.dart';
import '../utils/translations.dart';
import '../services/translation_service.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  bool _isShutterClicked = false;
  String _translatedText = '';
  final _translationService = TranslationService();

  String language1 = 'English';
  String language2 = 'English';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    PreferenceUtil.getImageLanguage().then((value) => setState(() {
          language1 = value;
        }));
    PreferenceUtil.getUserLanguage().then((value) => setState(() {
          language2 = value;
        }));
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

    final imageBytes = await imageFile.readAsBytes();
    final imageLanguage = await PreferenceUtil.getImageLanguage();

    final userLanguage = await PreferenceUtil.getUserLanguage();
    final languageCode = Translations.getLanguageCode(userLanguage);

    print('Image language: $imageLanguage');

    var request =
        http.MultipartRequest('POST', Uri.parse('$NGROK_API_URL/extract_text'));
    request.fields['lang'] = imageLanguage;
    request.files.add(http.MultipartFile.fromBytes('file', imageBytes,
        filename: 'image.jpg', contentType: MediaType('image', 'jpeg')));

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      print('Upload successful');
      var response = await http.Response.fromStream(streamedResponse);

      var parsedResponse = jsonDecode(response.body);
      String text = parsedResponse['text'];

      print('Response body: $text');

      final translatedContent = await _translationService.translate(text, languageCode);

      setState(() {
        _translatedText = translatedContent;
      });

      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  _translatedText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
            ),
          );
        },
      );

    } else {
      print('Upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: buildTitle(),
      ),
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
              iconSize: 70.0,
              onPressed: _takePicture,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitle() => TitleWidget(
        language1: language1,
        language2: language2,
        onChangedLanguage1: (newLanguage) => {
          setState(() {
            language1 = newLanguage!;
          }),
          PreferenceUtil.setImageLanguage(newLanguage ?? 'English')
        },
        onChangedLanguage2: (newLanguage) => {
          setState(() {
            language2 = newLanguage!;
          }),
          PreferenceUtil.setUserLanguage(newLanguage ?? 'English')
        },
        saveConversation: () {},
      );
}
