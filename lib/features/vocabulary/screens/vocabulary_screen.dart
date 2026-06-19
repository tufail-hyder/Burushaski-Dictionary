import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:burushashki_dictionary/core/constants/colors.dart';

import '../controllers/vocabulary_controller.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VocabularyController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.words.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.menu_book,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No words found',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.words.length,
          itemBuilder: (context, index) {
            final word = controller.words[index];
            final isFavorite = controller.storageService.isFavorite(word);

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                title: Text(
                  word.word,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      word.meaning,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (word.wordClass != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Class: ${word.wordClass}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => controller.toggleFavorite(word),
                ),
                onTap: () => _showWordDetails(context, word, controller),
              ),
            );
          },
        );
      }),
    );
  }

  void _showWordDetails(BuildContext context, dynamic word, VocabularyController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) => WordDetailsSheet(word: word, controller: controller),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}

class WordDetailsSheet extends StatelessWidget {
  final dynamic word;
  final VocabularyController controller;

  const WordDetailsSheet({
    super.key,
    required this.word,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                word.word,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(() {
                final isFavorite = controller.storageService.isFavorite(word);
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => controller.toggleFavorite(word),
                );
              }),
            ],
          ),
          const Divider(height: 24),
          Text(
            'Meaning',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            word.meaning,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (word.wordClass != null) ...[
            const SizedBox(height: 16),
            Text(
              'Word Class',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              word.wordClass,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
          if (word.example != null) ...[
            const SizedBox(height: 16),
            Text(
              'Example',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              word.example,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => controller.getPronunciation(word.word),
              icon: const Icon(Icons.volume_up),
              label: const Text('Hear Pronunciation'),
            ),
          ),
        ],
      ),
    );
  }
}
