import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import '../models/word_model.dart';

class LocalStorageService {
  static const String favoritesKey = 'favorites';
  static const String historyKey = 'search_history';

  final box = GetStorage();

  /// Add word to favorites
  Future<void> addFavorite(Word word) async {
    List<String> favorites = getFavorites().cast<String>();
    String wordJson = jsonEncode(word.toJson());
    if (!favorites.contains(wordJson)) {
      favorites.add(wordJson);
      await box.write(favoritesKey, favorites);
    }
  }

  /// Remove word from favorites
  Future<void> removeFavorite(Word word) async {
    List<String> favorites = getFavorites().cast<String>();
    String wordJson = jsonEncode(word.toJson());
    favorites.removeWhere((item) => item == wordJson);
    await box.write(favoritesKey, favorites);
  }

  /// Get all favorites
  List<Word> getFavorites() {
    List<String>? favorites = box.read(favoritesKey);
    if (favorites == null) return [];

    return favorites
        .map((item) => Word.fromJson(jsonDecode(item)))
        .toList();
  }

  /// Check if word is favorite
  bool isFavorite(Word word) {
    List<Word> favorites = getFavorites();
    return favorites.any((fav) => fav.word == word.word);
  }

  /// Add to search history
  Future<void> addToHistory(String word) async {
    List<String> history = getHistory();
    // Remove if already exists to avoid duplicates
    history.removeWhere((item) => item == word);
    // Add to beginning
    history.insert(0, word);
    // Keep only last 50 searches
    if (history.length > 50) {
      history = history.sublist(0, 50);
    }
    await box.write(historyKey, history);
  }

  /// Get search history
  List<String> getHistory() {
    List<String>? history = box.read(historyKey);
    return history ?? [];
  }

  /// Clear search history
  Future<void> clearHistory() async {
    await box.remove(historyKey);
  }

  /// Clear all data
  Future<void> clearAll() async {
    await box.erase();
  }
}
