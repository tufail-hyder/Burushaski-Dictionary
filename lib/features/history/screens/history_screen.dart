import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:burushashki_dictionary/core/constants/colors.dart';

import '../controllers/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search History'),
        elevation: 0,
        backgroundColor: AppColors.primary,
        actions: [
          if (controller.history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () => _showClearDialog(context, controller),
            ),
        ],
      ),
      body: Obx(() {
        if (controller.history.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.history,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No search history',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Your recent searches will appear here',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.history.length,
          itemBuilder: (context, index) {
            final word = controller.history[index];

            return ListTile(
              leading: const Icon(Icons.history, color: AppColors.primary),
              title: Text(word),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => controller.removeFromHistory(word),
              ),
              onTap: () => controller.searchWord(word),
            );
          },
        );
      }),
    );
  }

  void _showClearDialog(BuildContext context, HistoryController controller) {
    Get.defaultDialog(
      title: 'Clear History',
      middleText: 'Are you sure you want to clear all search history?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.clearAllHistory();
        Get.back();
        Get.snackbar('Success', 'Search history cleared');
      },
    );
  }
}
