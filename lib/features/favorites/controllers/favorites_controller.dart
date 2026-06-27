import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/vocabulary_mode.dart';

class FavoritesController extends GetxController {

  final box = GetStorage();

  RxList<VocabularyModel> favorites = <VocabularyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    final List? data = box.read("favorites");

    if (data != null) {
      favorites.value = data
          .map((e) => VocabularyModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
  }

  bool isFavorite(String word) {
    return favorites.any((e) => e.word == word);
  }

  void toggleFavorite(VocabularyModel vocabulary) {

    if (isFavorite(vocabulary.word)) {

      favorites.removeWhere(
              (e) => e.word == vocabulary.word);

    } else {

      favorites.add(vocabulary);

    }

    box.write(
      "favorites",
      favorites.map((e) => e.toJson()).toList(),
    );
  }
}