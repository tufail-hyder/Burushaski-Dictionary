import 'package:get/get.dart';

class LanguageController extends GetxController {
  var isEnglish = true.obs;

  void swapLanguage() {
    isEnglish.value = !isEnglish.value;
  }
}