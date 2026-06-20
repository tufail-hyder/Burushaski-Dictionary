import 'dart:convert';
import 'package:http/http.dart' as http;

class DictionaryApi {
  static const String baseUrl = "http://192.168.1.13:8080/api";

  // 🔍 Autocomplete
  static Future<List<String>> autoComplete(String word) async {
    final url = Uri.parse("$baseUrl/dictionary/autocomplete?word=$word");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => e.toString()).toList();
    }

    return [];
  }

  // 📖 Full search
  static Future<dynamic> search(String word) async {
    try {
      final url = Uri.parse("$baseUrl/dictionary/search?word=$word");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // if API returns list → take first item
        if (data is List && data.isNotEmpty) {
          return data[0];
        }

        // if API returns object
        if (data is Map<String, dynamic>) {
          return data;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}