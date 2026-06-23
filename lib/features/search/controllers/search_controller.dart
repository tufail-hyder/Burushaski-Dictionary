import 'dart:async';
import 'package:get/get.dart';
import '../../../models/vocabulary_mode.dart';
import '../../../services/dictionary_api.dart';

class DictionarySearchController extends GetxController {

  final RxList<VocabularyModel> suggestions = <VocabularyModel>[].obs;

  Timer? _debounce;

  void onSearchChanged(String value) {

    _debounce?.cancel();

    if (value.trim().isEmpty) {
      suggestions.clear();
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 400),
          () async {

        final words = await DictionaryApi.autoComplete(value);

        final List<VocabularyModel> temp = [];

        for (final w in words.take(8)) {

          final data = await DictionaryApi.search(w);

          if (data != null) {

            temp.add(
              VocabularyModel.fromJson(data),
            );
          }
        }

        suggestions.value = temp;
      },
    );
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}