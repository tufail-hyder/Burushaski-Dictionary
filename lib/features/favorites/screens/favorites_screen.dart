import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:burushashki_dictionary/core/constants/colors.dart';

import '../controllers/favorites_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        elevation: 0,
        backgroundColor: AppColors.primary,
        actions: [
          if (controller.favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () => _showClearDialog(context, controller),
            ),
        ],
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorites yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Words you mark as favorite will appear here',
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
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final word = controller.favorites[index];

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
                subtitle: Text(
                  word.meaning,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () => controller.removeFavorite(word),
                ),
                onTap: () => _showWordDetails(context, word, controller),
              ),
            );
          },
        );
      }),
    );
  }

  void _showWordDetails(BuildContext context, dynamic word, FavoritesController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) => WordDetailsSheet(word: word, controller: controller),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void _showClearDialog(BuildContext context, FavoritesController controller) {
    Get.defaultDialog(
      title: 'Clear Favorites',
      middleText: 'Are you sure you want to remove all favorites?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.clearAllFavorites();
        Get.back();
        Get.snackbar('Success', 'All favorites cleared');
      },
    );
  }
}

class WordDetailsSheet extends StatelessWidget {
  final dynamic word;
  final FavoritesController controller;

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
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  controller.removeFavorite(word);
                  Get.back();
                  Get.snackbar('Removed', 'Removed from favorites');
                },
              ),
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
        ],
      ),
    );
  }
}
