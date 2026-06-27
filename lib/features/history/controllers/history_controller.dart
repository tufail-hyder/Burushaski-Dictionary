import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/vocabulary_mode.dart';

class HistoryController extends GetxController {
  final box = GetStorage();

  RxList<VocabularyModel> history = <VocabularyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  void loadHistory() {
    final List? data = box.read("history");

    if (data != null) {
      history.value = data
          .map(
            (e) => VocabularyModel.fromJson(
          Map<String, dynamic>.from(e),
        ),
      )
          .toList();
    }
  }

  void addHistory(VocabularyModel vocabulary)
  {
    // Remove duplicate if already exists
    history.removeWhere(
          (e) => e.word == vocabulary.word,
    );

    // Add at top
    history.insert(0, vocabulary);

    // Keep only latest 100 words
    if (history.length > 100)
    {
      history.removeLast();
    }

    box.write("history", history.map((e) => e.toJson()).toList(),);
  }

  void clearHistory() {history.clear();box.remove("history");
  }
}