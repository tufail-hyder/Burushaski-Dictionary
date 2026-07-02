import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../wordDetails/screens/word_details_screen.dart';
import '../controllers/word_of_day_controller.dart';

class WordOfDayScreen extends StatelessWidget {
  WordOfDayScreen({super.key});

  final controller = Get.put(WordOfDayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.vocabulary.value == null) {
          return const Center(
            child: Text("No Word Found"),
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.off(() => WordDetailScreen(
            vocabulary: controller.vocabulary.value!,
          ));
        });

        return const SizedBox();
      }),
    );
  }
}