import 'package:get/get.dart';
import '../../../models/word_model.dart';
import '../../../services/dictionary_api.dart';

class WordController extends GetxController {
  var isLoading = false.obs;
  var error = "".obs;

  var word = "".obs;
  var meaning = "".obs;
  final Rxn<WordModel> wordData = Rxn<WordModel>();

  Future<void> fetchWord(String w) async {
    if (w.isEmpty) return;

    try {
      isLoading.value = true;
      error.value = '';

      final data = await DictionaryApi.search(w);

      if (data == null) {
        error.value = 'Word not found';
        word.value = w;
        meaning.value = '';
        return;
      }

      word.value = data['word']?.toString() ?? w;

      // 🔥 IMPORTANT FIX HERE
      if (data['meaning'] is List) {
        meaning.value = (data['meaning'] as List).join(", ");
      } else {
        meaning.value =
            data['meaning']?.toString() ??
                data['definitions']?.toString() ??
                'No meaning available';
      }

      wordData.value = WordModel.fromJson(
        Map<String, dynamic>.from(data),
      );
    } catch (e) {
      error.value = 'Something went wrong: $e';
    } finally {
      isLoading.value = false;
    }
  }

}