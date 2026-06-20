import 'package:get/get.dart';
import '../../../services/dictionary_api.dart';

class DictionarySearchController extends GetxController {
  final Rxn<Map<String, dynamic>> wordData = Rxn<Map<String, dynamic>>();
  final RxBool isLoading = false.obs;

  // 🔍 SEARCH WORD
  Future<void> fetchWord(String word) async {
    try {
      isLoading.value = true;

      final result = await DictionaryApi.search(word);

      if (result != null) {
        wordData.value = Map<String, dynamic>.from(result);
      } else {
        wordData.value = null;
      }
    } catch (e) {
      wordData.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  // 🔍 AUTOCOMPLETE
  Future<void> onSearchChanged(String value) async {
    if (value.isEmpty) {
      suggestions.clear();
      return;
    }

    final results = await DictionaryApi.autoComplete(value);
    suggestions.value = results;
  }

  final RxList<String> suggestions = <String>[].obs;
}