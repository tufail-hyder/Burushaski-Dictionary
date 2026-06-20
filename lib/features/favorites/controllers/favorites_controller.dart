import 'package:get/get.dart';

class FavoritesController extends GetxController {
  var favorites = <String>[].obs;

  void toggleFavorite(String word) {
    if (favorites.contains(word)) {
      favorites.remove(word);
    } else {
      favorites.add(word);
    }
  }

  bool isFavorite(String word) {
    return favorites.contains(word);
  }
}