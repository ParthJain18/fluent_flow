import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MessageInputField extends StatefulWidget {
  final TextEditingController messageController;
  final VoidCallback onSendPressed;
  final VoidCallback swapIsMe;
  final Future<String> Function() summarizeConversation;

  const MessageInputField({
    super.key,
    required this.messageController,
    required this.onSendPressed,
    required this.swapIsMe,
    required this.summarizeConversation,
  });

  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  bool _isListening = false;
  stt.SpeechToText speech = stt.SpeechToText();
  final ScrollController _controller = ScrollController();

  Future<bool> getMicrophonePermission() async {
    bool hasPermission = await speech.initialize(
      onError: (error) =>
          print('Error initializing speech recognition: $error'),
    );

    if (!hasPermission) {
      print('Permission not granted');
      bool isPermissionGranted = false;
      // bool isPermissionGranted = await speech.;
      //
      // if (!isPermissionGranted) {
      //   print('Microphone permission not granted');
      // }
      return isPermissionGranted;
    }

    return true;
  }

  void startSpeechRecognition() {
    speech.listen(
      onResult: (result) => {
        print('Recognition result: ${result.recognizedWords}'),
        widget.messageController.text = result.recognizedWords
      },
      listenFor: const Duration(seconds: 5),
      cancelOnError: true,
    );

    setState(() {
      _isListening = false;
    });
  }

  void stopSpeechRecognition() {
    speech.stop();
  }

  void disposeSpeechRecognition() {
    speech.cancel();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });

    if (_isListening == false && speech.isListening) {
      speech.stop();
      return;
    }

    getMicrophonePermission().then((hasPermission) {
      if (hasPermission) {
        startSpeechRecognition();
      }
    });
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
  void dispose() {
    disposeSpeechRecognition();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: widget.swapIsMe,
            icon: const Icon(Icons.swap_horiz_rounded)),
        IconButton(
          onPressed: () {
            Future<String> summaryFuture = widget.summarizeConversation();
            showModalBottomSheet(
              context: context,
              builder: (builder) {
                return FutureBuilder<String>(
                  future: summaryFuture,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading summary'));
                    } else {
                      return SizedBox(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                              softWrap: true,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          },
          icon: const Icon(
            CupertinoIcons.sparkles,
            color: Colors.black, // Change icon color here
            size: 30, // Change icon size here
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: widget.messageController,
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
          onPressed: () {
            widget.onSendPressed();
            _scrollToBottom();
          },
        ),
        IconButton(
          icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
          onPressed: _toggleListening,
        ),
      ],
    );
  }
}
