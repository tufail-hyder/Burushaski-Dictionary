import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vocabulary_mode.dart';
import 'dart:typed_data';

class DictionaryApi {
  static const String baseUrl = "http://192.168.1.6:8080/api";

  // Autocomplete
  static Future<List<String>> autoComplete(String word) async {
    final url = Uri.parse("$baseUrl/dictionary/autocomplete?word=$word");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => e.toString()).toList();
    }

    return [];
  }

  //search
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

  // ALl Words
  static Future<List<VocabularyModel>> getAllWords() async {
    try {
      final url = Uri.parse(
        '$baseUrl/dataset/mobile?limit=2000&meanings=3',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        return data
            .map(
              (e) => VocabularyModel.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
            .toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

 // Pronunciation
  static Future<Uint8List?> getPronunciationAudio(String word) async {
    try {
      final url = Uri.parse(
        "$baseUrl/pronounce/pronounce?word=$word",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Uint8List.fromList(response.bodyBytes);
      }

      return null;
    } catch (e)
    {
      return null;
    }
  }

  // Request Word(Add More)
  static Future<bool> requestWord(
      String word,
      String meaning,
      ) async {

    try {

      final response = await http.post(

        Uri.parse("$baseUrl/request-word"),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({

          "word": word,

          "meaning": meaning,

        }),
      );

      return response.statusCode == 200 ||
          response.statusCode == 201;

    } catch (e) {

      return false;

    }
  }
}