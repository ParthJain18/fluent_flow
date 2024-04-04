import 'dart:convert';
import 'package:http/http.dart' as http;

class SuggestionService {
  Future<List> generateSuggestions(String text) async {

    print('Generating suggestions for $text...');

    final response = await http.post(
      Uri.parse('http://localhost:8000/suggestions'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'text': text}),  // Send the data as a JSON string
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['suggestions'].runtimeType);



      return data['suggestions'];
    } else {
      throw Exception('Failed to load translation');
    }
  }
}