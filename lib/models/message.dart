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

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'translatedContent': translatedContent,
      'englishTranslatedContent': englishTranslatedContent,
      'isMe': isMe,
      'isLoading': isLoading,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      translatedContent: json['translatedContent'],
      englishTranslatedContent: json['englishTranslatedContent'],
      isMe: json['isMe'],
      isLoading: json['isLoading'],
    );
  }
}