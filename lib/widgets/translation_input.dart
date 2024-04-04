import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_flow/models/message.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;
import 'package:fluent_flow/services/translation_service.dart';

import '../utils/preference_util.dart';
import '../utils/translations.dart';

class TranslationInput extends StatefulWidget {
  const TranslationInput({super.key});


  @override
  _TranslationInputState createState() => _TranslationInputState();
}

class _TranslationInputState extends State<TranslationInput> {

  final _translationService = TranslationService();

  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final ScrollController _controller = ScrollController();
  bool isMe = true;

  late stt.SpeechToText _speech;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    if (Platform.isAndroid) {
      PermissionStatus status = await Permission.microphone.request();
      if (status.isGranted) {
        bool available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'),
        );
        if (available) {
          _speech.listen(
            onResult: (val) => setState(() {
              _lastWords = val.recognizedWords;
              _messageController.text = _lastWords;
            }),
          );
        } else {
          print("The user has denied the use of speech recognition.");
        }
      } else {
        print("Microphone permission is denied.");
      }
    } else {
      print("Microphone functionality is not available on this platform.");
    }
  }

  void _stopListening() {
    _speech.stop();
  }

  play(String content) {
    // Add code here
  }
  void _swapIsMe() {
    setState(() {
      isMe = !isMe;
    });
  }

  void _sendMessage() async {
    _lastWords = _messageController.text;
    if (_lastWords.isEmpty) {
      return;
    }
    String language1 = await PreferenceUtil.getLanguage1();
    String language2 = await PreferenceUtil.getLanguage2();

    String languageCode1 = Translations.getLanguageCode(language1);
    String languageCode2 = Translations.getLanguageCode(language2);

    setState(() {
      _messages.add(Message(
          content: _lastWords,
          translatedContent: 'Loading...',
          isMe: isMe,
          isLoading: true));
    });

    String targetLanguage = isMe ? languageCode1 : languageCode2;

    final translatedContent = await _translationService.translate(_lastWords, targetLanguage);

    _lastWords = '';
    _messageController.clear();


    setState(() {
      _messages.last.translatedContent = translatedContent;
      _messages.last.isLoading = false;
    });

    _swapIsMe();
    _scrollToBottom();
    _stopListening();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text('No messages yet'),
                  )
                : ListView.builder(
              controller: _controller,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: message.isMe
                            ? Colors.blue[100]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                    child: Text(
                                      message.content,
                                      textAlign: message.isMe
                                          ? TextAlign.end
                                          : TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                    child: message.isLoading
                                        ? const CircularProgressIndicator()
                                        : Text(
                                      message.translatedContent,
                                      textAlign: message.isMe
                                          ? TextAlign.end
                                          : TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: _swapIsMe, icon: const Icon(Icons.swap_horiz_rounded)),
              IconButton(
                  onPressed: _swapIsMe, icon: const Icon(CupertinoIcons.sparkles)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _messageController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send_rounded),
                onPressed: _sendMessage,
              ),
              IconButton(
                icon: const Icon(Icons.mic),
                onPressed: _startListening,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
