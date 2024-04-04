class Message {
  final String content;
  String translatedContent;
  final bool isMe;
  bool isLoading;

  Message({
    required this.content,
    required this.translatedContent,
    required this.isMe,
    this.isLoading = false,
  });
}