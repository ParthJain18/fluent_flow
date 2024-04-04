import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  final _apiKey = 'AIzaSyCjoFTEGuc6t_88rwT6D5I0YliTtC0eesk'; // Replace with your API key

  Future<String> translate(String text, String targetLanguage) async {
    print('Translating $text to $targetLanguage...');
    final response = await http.get(
      Uri.parse('https://translation.googleapis.com/language/translate/v2?'
          'q=$text&'
          'target=$targetLanguage&'
          'key=$_apiKey'),
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Failed to load translation');
    }
  }
}