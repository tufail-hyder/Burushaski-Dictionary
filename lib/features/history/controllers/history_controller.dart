import 'package:get/get.dart';
import 'package:burushashki_dictionary/features/search/controllers/search_controller.dart';

import '../../../services/local_storage_service.dart';

class HistoryController extends GetxController {
  final storageService = LocalStorageService();

  RxList<String> history = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  /// Load history from storage
  void loadHistory() {
    history.value = storageService.getHistory();
  }

  /// Remove a word from history
  Future<void> removeFromHistory(String word) async {
    history.removeWhere((item) => item == word);
    // Save updated history
    for (int i = 0; i < history.length; i++) {
      await storageService.addToHistory(history[i]);
    }
    loadHistory();
  }

  /// Clear all history
  Future<void> clearAllHistory() async {
    await storageService.clearHistory();
    loadHistory();
  }

  /// Search for a word from history
  void searchWord(String word) {
    final searchController = Get.find<DictionarySearchController>();
    searchController.searchWord(word);
    Get.back();
  }
}
