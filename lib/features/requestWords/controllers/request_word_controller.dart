import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/dictionary_api.dart';

class RequestWordController extends GetxController {

  final wordController = TextEditingController();

  final meaningController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> submitWord() async {

    final word = wordController.text.trim();

    final meaning = meaningController.text.trim();

    if (word.isEmpty || meaning.isEmpty) {
      Get.snackbar(
        "Required",
        "Please enter both Word and Meaning",
      );
      return;
    }

    isLoading.value = true;

    final success = await DictionaryApi.requestWord(
      word,
      meaning,
    );

    isLoading.value = false;

    if (success) {

      wordController.clear();

      meaningController.clear();

      Get.snackbar(
        "Submitted",
        "Your request has been submitted successfully.",
      );

    } else {

      Get.snackbar(
        "Error",
        "Failed to submit request.",
      );
    }
  }

  @override
  void onClose() {
    wordController.dispose();
    meaningController.dispose();
    super.onClose();
  }
}