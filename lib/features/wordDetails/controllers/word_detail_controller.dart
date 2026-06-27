import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../models/vocabulary_mode.dart';
import '../../../services/dictionary_api.dart';

class WordDetailController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  final box = GetStorage();

  Future<void> speakWord(String word) async {
    try {
      final audioBytes =
      await DictionaryApi.getPronunciationAudio(word);

      if (audioBytes == null) {
        Get.snackbar(
          "Error",
          "Pronunciation not available",
        );
        return;
      }

      final directory = await getTemporaryDirectory();

      final file = File(
        "${directory.path}/$word.mp3",
      );

      await file.writeAsBytes(audioBytes);

      await player.stop();

      await player.play(
        DeviceFileSource(file.path),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  void copyMeaning(String meaning) {
    Clipboard.setData(
      ClipboardData(text: meaning),
    );

    Get.snackbar(
      "Copied",
      "Meaning copied successfully",
    );
  }

  void shareWord(VocabularyModel vocabulary) {
    Share.share(
      "${vocabulary.word}\n\n${vocabulary.meaning}",
    );
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}