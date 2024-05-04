import '../models/message.dart';
import 'preference_util.dart';

void saveConversationHistory(List<Message> messages) {
  print('Saving conversation history...');

  PreferenceUtil.saveHistory(messages);

}