import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../../wordDetails/screens/word_details_screen.dart';
import '../controllers/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () {
              Get.defaultDialog(title: "Delete History",
                middleText: "Are you sure you want to delete your history?",
                textCancel: "Cancel",
                textConfirm: "Delete",
                confirmTextColor: Colors.white,
                buttonColor: AppColors.primary,

                onConfirm: () {
                  controller.clearHistory();
                  Get.back();

                  Get.snackbar("Success", "History deleted successfully", snackPosition: SnackPosition.BOTTOM,);
                },
              );
            },
          ),
        ],
      ),

      body: Obx(() {
        if (controller.history.isEmpty) {
          return const Center(
            child: Text("No History"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.history.length,
          itemBuilder: (_, index) {
            final word = controller.history[index];

            return Card(
              child: ListTile(
                leading: const Icon(Icons.history),

                title: Text(word.word),

                subtitle: Text(
                  word.meaning,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                trailing: const Icon(Icons.chevron_right),

                onTap: () {
                  Get.to(() => WordDetailScreen(vocabulary: word,),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}