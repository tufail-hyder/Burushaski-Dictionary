import 'package:get/get.dart';
import '../../../models/word_model.dart';
import '../../../services/api_service.dart';
import '../../../services/local_storage_service.dart';

class DictionarySearchController extends GetxController {
  final apiService = ApiService();
  final storageService = LocalStorageService();

  RxList<Word> searchResults = <Word>[].obs;
  RxList<String> autocompleteResults = <String>[].obs;
  RxList<String> searchHistory = <String>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingAutoComplete = false.obs;
  RxString errorMessage = ''.obs;
  RxString selectedWord = ''.obs;
  Rx<Word?> selectedWordData = Rx<Word?>(null);

  @override
  void onInit() {
    super.onInit();
    loadSearchHistory();
  }

  /// Search for words
  Future<void> searchWord(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      autocompleteResults.clear();
      return;
    }

    // Get autocomplete suggestions
    await getAutocompleteSuggestions(query);

    // Get search results
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final results = await apiService.searchWords(query);
      searchResults.value = results;

      if (results.isEmpty) {
        errorMessage.value = 'No words found';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Get autocomplete suggestions
  Future<void> getAutocompleteSuggestions(String query) async {
    if (query.isEmpty) {
      autocompleteResults.clear();
      return;
    }

    isLoadingAutoComplete.value = true;
    try {
      final suggestions = await apiService.getAutocomplete(query);
      autocompleteResults.value = suggestions;
    } catch (e) {
      print('Autocomplete error: $e');
    } finally {
      isLoadingAutoComplete.value = false;
    }
  }

  /// Get word details with pronunciation
  Future<void> getWordDetails(Word word) async {
    selectedWord.value = word.word;
    selectedWordData.value = word;

    // Add to history
    await storageService.addToHistory(word.word);
    loadSearchHistory();

    // Get pronunciation
    final pronunciation = await apiService.getPronunciation(word.word);
    if (pronunciation != null) {
      print('Pronunciation: ${pronunciation.phonetic}');
      // You can store this in a separate variable or update the Word object
    }
  }

  /// Toggle favorite
  Future<void> toggleFavorite(Word word) async {
    if (storageService.isFavorite(word)) {
      await storageService.removeFavorite(word);
    } else {
      await storageService.addFavorite(word);
    }
    // Update the word's favorite status
    word.isFavorite = !word.isFavorite;
    update();
  }

  /// Load search history
  void loadSearchHistory() {
    searchHistory.value = storageService.getHistory();
  }

  /// Clear search history
  Future<void> clearSearchHistory() async {
    await storageService.clearHistory();
    loadSearchHistory();
  }

  /// Search from history
  Future<void> searchFromHistory(String word) async {
    await searchWord(word);
  }
}
