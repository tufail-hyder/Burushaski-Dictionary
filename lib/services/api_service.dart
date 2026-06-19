import 'package:dio/dio.dart';
import '../core/config/api_config.dart';
import '../models/pronunciation_model.dart';
import '../models/word_model.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
      ),
    );

    // Add interceptors for logging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  /// Search for words with filter
  Future<List<Word>> searchWords(String query) async {
    try {
      final response = await _dio.get(
        '/dictionary/search',
        queryParameters: {'word': query},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          return data.map((item) {
            return Word(
              word: query,
              meaning: item.toString(),
            );
          }).toList();
        }
      }

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  /// Get autocomplete suggestions
  Future<List<String>> getAutocomplete(String word) async {
    try {
      final response = await _dio.get(
        '/dictionary/autocomplete',
        queryParameters: {'word': word},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data.containsKey('data')) {
          List<dynamic> results = data['data'];
          return results.map((item) => item.toString()).toList();
        } else if (data is List) {
          return data.map((item) => item.toString()).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error getting autocomplete: $e');
      return [];
    }
  }

  /// Get pronunciation for a word
  Future<Pronunciation?> getPronunciation(String word) async {
    try {
      final response = await _dio.get(
        '/pronounce/pronounce',
        queryParameters: {'word': word},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data.containsKey('data')) {
          return Pronunciation.fromJson(data['data']);
        } else if (data is Map) {
          return Pronunciation.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      print('Error getting pronunciation: $e');
      return null;
    }
  }

  /// Get all words (paginated)
  Future<List<Word>> getAllWords({int page = 1, int limit = 50}) async {
    try {
      final response = await _dio.get(
        '/dictionary/words',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data.containsKey('data')) {
          List<dynamic> results = data['data'];
          return results
              .map((item) => Word.fromJson(item))
              .toList();
        } else if (data is List) {
          return data
              .map((item) => Word.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Error getting all words: $e');
      return [];
    }
  }

  /// Get word of the day
  Future<Word?> getWordOfTheDay() async {
    try {
      final response = await _dio.get('/dictionary/word-of-day');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data.containsKey('data')) {
          return Word.fromJson(data['data']);
        } else if (data is Map) {
          return Word.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      print('Error getting word of the day: $e');
      return null;
    }
  }
}
