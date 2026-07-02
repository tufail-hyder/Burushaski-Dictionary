import 'package:get/get.dart';
import '../../../models/vocabulary_mode.dart';
import '../../../services/dictionary_api.dart';

class DictionarySearchController extends GetxController {
  final RxList<VocabularyModel> allWords = <VocabularyModel>[].obs;
  final RxList<VocabularyModel> suggestions = <VocabularyModel>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadVocabulary();
  }

  Future<void> loadVocabulary() async {
    isLoading.value = true;

    allWords.value = await DictionaryApi.getAllWords();

    isLoading.value = false;
  }

  void onSearchChanged(String value)
  {

    if (value.trim().isEmpty) {
      suggestions.clear();
      return;
    }

    final query = value.toLowerCase();

    suggestions.value = allWords.where((item) {
      return item.word.toLowerCase().contains(query) ||
          item.meaning.toLowerCase().contains(query);
    }).take(20).toList();
  }
}