class Message {
  final String content;
  String translatedContent;
  String englishTranslatedContent;
  final bool isMe;
  bool isLoading;

  Message({
    required this.content,
    required this.translatedContent,
    required this.isMe,
    this.englishTranslatedContent = '',
    this.isLoading = false,
  });
}