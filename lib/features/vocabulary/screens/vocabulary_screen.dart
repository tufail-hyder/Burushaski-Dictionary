import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../wordDetails/screens/word_details_screen.dart';
import '../controllers/vocabulary_controller.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VocabularyController());

    return Scaffold(
      appBar: AppBar(
          title: Text('Vocabulary', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }
        if (controller.words.isEmpty) {
          return const Center(child: Text('No words found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.words.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (_, index) {
            final item = controller.words[index];

            return Card(
              child: ListTile(
                title: Text(item.word, style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item.meaning),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.to(
                        () => WordDetailScreen(vocabulary: item,),
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