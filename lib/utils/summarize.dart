import '../models/message.dart';
import '../services/summarize.dart';

Future<String> summarizeConversation(List<Message> messages) async {

  final summarizationService = SummarizationService();

  String conversation = '';
  for (var message in messages) {
    if (message.isMe) {
      conversation += '${"User: ${message.englishTranslatedContent}"}\n';
    } else {
      conversation +=
          '${"Second User: ${message.englishTranslatedContent}"}\n';
    }
  }

  if (conversation.isEmpty) {
    return "No conversation to summarize";
  }

  final summary = await summarizationService.summarize(conversation);
  print('Summary: $summary');

  return summary;
}
