import 'package:fluent_flow/widgets/MessageInputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_flow/models/message.dart';
import 'package:fluent_flow/services/translation_service.dart';
import '../services/suggestions.dart';
import '../state/translation_input_state.dart';
import '../utils/preference_util.dart';
import '../utils/summarize.dart';
import '../utils/translations.dart';
import 'package:provider/provider.dart';
import 'MessageList.dart';
import 'SuggestionList.dart';

class TranslationChatInterface extends StatefulWidget {
  final List<Message> messageList;
  const TranslationChatInterface({super.key, required this.messageList});

  @override
  _TranslationChatInterfaceState createState() =>
      _TranslationChatInterfaceState();
}

class _TranslationChatInterfaceState extends State<TranslationChatInterface> {
  final _translationService = TranslationService();
  final _suggestionService = SuggestionService();

  final TextEditingController _messageController = TextEditingController();
  // final List<Message> _messages = messageList.messages;
  // final List<Message> _messages = [
  //   Message(
  //       content: "content", translatedContent: "translatedContent", isMe: true)
  // ];
  final ScrollController _controller = ScrollController();
  // final List<String> _suggestions = [];
  final List<String> _suggestions = [];

  String text = '';

  bool isMe = true;

  String _lastWords = '';

  play(String content) {
    // Add code here
  }

  void _swapIsMe() {
    setState(() {
      isMe = !isMe;
    });
  }

  Future<String> getSummary() async {
    String summary = await summarizeConversation(widget.messageList);
    return summary;
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
    String targetLanguage = isMe ? languageCode1 : languageCode2;
    String speakerLanguage = isMe ? languageCode2 : languageCode1;

    print('language1: $language1');
    print('language2: $language2');

    String englishTranslatedContent = '';
    setState(() {
      _suggestions.clear();
    });

    setState(() {
      widget.messageList.add(Message(
          content: _lastWords,
          translatedContent: 'Loading...',
          isMe: isMe,
          isLoading: true));
    });

    _messageController.clear();

    print("Target Language: $targetLanguage");

    final translatedContent =
        await _translationService.translate(_lastWords, targetLanguage);

    if (targetLanguage == 'en') {
      print('translatedContent: $translatedContent');
      englishTranslatedContent = translatedContent;
    } else if (speakerLanguage == 'en') {
      englishTranslatedContent = _lastWords;
      print('translatedContent: $englishTranslatedContent');
    } else {
      englishTranslatedContent =
          await _translationService.translate(_lastWords, 'en');
      print('translatedContent: $englishTranslatedContent');
    }

    _lastWords = '';

    setState(() {
      widget.messageList.last.translatedContent = translatedContent;
      widget.messageList.last.englishTranslatedContent =
          englishTranslatedContent;
      widget.messageList.last.isLoading = false;
    });

    if (!isMe) {
      String text = widget.messageList.last.englishTranslatedContent;
      final suggestions = await _suggestionService.generateSuggestions(text);
      if (suggestions.isNotEmpty) {
        for (var suggestion in suggestions) {
          _suggestions.add(languageCode2 == 'en'
              ? suggestion
              : await _translationService.translate(suggestion, languageCode2));
          // print('suggestion: $suggestion');
          // print('suggestion: $_suggestions');
          // print(_suggestions.runtimeType);
        }
      }
    }

    _swapIsMe();
    _scrollToBottom();
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
    return ChangeNotifierProvider(
      create: (_) => TranslationInputState(),
      child: Consumer<TranslationInputState>(
        builder: (context, state, _) => SizedBox(
          height: MediaQuery.of(context).size.height - 150,
          child: Column(
            children: [
              Expanded(
                  child: MessageList(
                      messages: widget.messageList,
                      scrollController: _controller)),
              if (_suggestions.isNotEmpty)
                SuggestionList(
                    suggestions: _suggestions,
                    onTap: (int i) {
                      _messageController.text = _suggestions[i];
                    }),
              MessageInputField(
                  messageController: _messageController,
                  onSendPressed: _sendMessage,
                  // onMicPressed: recognizing ? () {} : _startListening,
                  swapIsMe: _swapIsMe,
                  summarizeConversation: getSummary),
            ],
          ),
        ),
      ),
    );
  }
}
