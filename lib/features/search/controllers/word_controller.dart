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
    try {
      isLoading.value = true;
      error.value = "";

      final data = await DictionaryApi.search(w);

      if (data == null) {
        error.value = "Word not found";
        return;
      }

      word.value = data['word'] ?? w;
      meaning.value = data['meaning'] ?? "No meaning available";

    } catch (e) {
      error.value = "Something went wrong";
    } finally {
      isLoading.value = false;
    }
  }

}