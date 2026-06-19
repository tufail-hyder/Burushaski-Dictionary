import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/word_model.dart';
import '../../../services/api_service.dart';
import '../../../services/local_storage_service.dart';

class VocabularyController extends GetxController {
  final apiService = ApiService();
  final storageService = LocalStorageService();

  RxList<Word> words = <Word>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxInt currentPage = 1.obs;
  RxBool hasMorePages = true.obs;

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    fetchWords();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  /// Fetch all words with pagination
  Future<void> fetchWords() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final newWords = await apiService.getAllWords(
        page: currentPage.value,
        limit: 50,
      );

      if (newWords.isEmpty) {
        hasMorePages.value = false;
      } else {
        words.addAll(newWords);
      }
    } catch (e) {
      print('Error fetching words: $e');
      Get.snackbar('Error', 'Failed to load words');
    } finally {
      isLoading.value = false;
    }
  }

  /// Infinite scroll listener
  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoadingMore.value && hasMorePages.value) {
        loadMoreWords();
      }
    }
  }

  /// Load more words
  Future<void> loadMoreWords() async {
    isLoadingMore.value = true;
    currentPage.value++;

    try {
      final newWords = await apiService.getAllWords(
        page: currentPage.value,
        limit: 50,
      );

      if (newWords.isEmpty) {
        hasMorePages.value = false;
      } else {
        words.addAll(newWords);
      }
    } catch (e) {
      print('Error loading more words: $e');
      currentPage.value--;
    } finally {
      isLoadingMore.value = false;
    }
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(Word word) async {
    if (storageService.isFavorite(word)) {
      await storageService.removeFavorite(word);
      word.isFavorite = false;
    } else {
      await storageService.addFavorite(word);
      word.isFavorite = true;
    }
    update();
  }

  /// Get pronunciation for a word
  Future<void> getPronunciation(String word) async {
    try {
      final pronunciation = await apiService.getPronunciation(word);
      if (pronunciation != null) {
        Get.snackbar(
          'Pronunciation',
          pronunciation.phonetic ?? 'Phonetic not available',
          duration: const Duration(seconds: 2),
        );
        // You can play audio here using a package like just_audio
        // if (pronunciation.audioUrl != null) {
        //   // Play audio
        // }
      }
    } catch (e) {
      print('Error getting pronunciation: $e');
    }
  }

  /// Refresh words list
  Future<void> refreshWords() async {
    currentPage.value = 1;
    words.clear();
    hasMorePages.value = true;
    await fetchWords();
  }
}
