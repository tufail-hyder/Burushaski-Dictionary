import 'package:get/get.dart';
import '../../../models/vocabulary_mode.dart';
import '../../../services/dictionary_api.dart';

class WordOfDayController extends GetxController {

  RxBool isLoading = true.obs;

  Rxn<VocabularyModel> vocabulary = Rxn<VocabularyModel>();

  @override
  void onInit() {
    super.onInit();
    loadWord();
  }

  Future<void> loadWord() async {
    isLoading.value = true;

    vocabulary.value = await DictionaryApi.getWordOfTheDay();

    isLoading.value = false;
  }
}