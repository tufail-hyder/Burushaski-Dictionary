import 'package:get/get.dart';

import '../../../models/word_model.dart';
import '../../../services/local_storage_service.dart';

class FavoritesController extends GetxController {
  final storageService = LocalStorageService();

  RxList<Word> favorites = <Word>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  /// Load favorites from storage
  void loadFavorites() {
    favorites.value = storageService.getFavorites();
  }

  /// Remove favorite
  Future<void> removeFavorite(Word word) async {
    await storageService.removeFavorite(word);
    loadFavorites();
  }

  /// Clear all favorites
  Future<void> clearAllFavorites() async {
    for (var word in favorites) {
      await storageService.removeFavorite(word);
    }
    loadFavorites();
  }
}
