class ApiConstants {
  static const String baseUrl = 'http://192.168.1.11:8080/api';

  static String autocomplete(String word) => '$baseUrl/dictionary/autocomplete?word=$word';
  static String searchMeaning(String word) => '$baseUrl/dictionary/search?word=$word';
  static String pronounce(String word) => '$baseUrl/pronounce/pronounce?word=$word';
}