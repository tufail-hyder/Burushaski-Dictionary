import 'package:get/get.dart';
import '../../../models/vocabulary_mode.dart';
import '../../../services/dictionary_api.dart';

class VocabularyController extends GetxController {
  final RxList<VocabularyModel> words = <VocabularyModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadWords();
  }

  Future<void> loadWords() async {
    try {
      isLoading.value = true;
      error.value = '';
      words.value = await DictionaryApi.getAllWords();
    } catch (_) {
      error.value = 'Failed to load vocabulary';
    } finally {
      isLoading.value = false;
    }
  }
}