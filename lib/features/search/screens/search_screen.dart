import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:burushashki_dictionary/core/constants/colors.dart';
import 'package:burushashki_dictionary/features/search/controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DictionarySearchController>();
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Dictionary'),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) => controller.searchWord(value),
              decoration: InputDecoration(
                hintText: 'Search a word...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Autocomplete suggestions
          Obx(() {
            if (controller.autocompleteResults.isEmpty) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggestions',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.autocompleteResults.length,
                      itemBuilder: (context, index) {
                        final suggestion = controller.autocompleteResults[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ActionChip(
                            label: Text(suggestion),
                            onPressed: () {
                              searchController.text = suggestion;
                              controller.searchWord(suggestion);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }),

          // Recent searches
          Obx(() {
            if (controller.searchHistory.isEmpty ||
                controller.searchResults.isNotEmpty) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextButton(
                        onPressed: () => controller.clearSearchHistory(),
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: controller.searchHistory
                        .take(5)
                        .map((word) => ListTile(
                      title: Text(word),
                      leading: const Icon(Icons.history, size: 18),
                      onTap: () {
                        searchController.text = word;
                        controller.searchWord(word);
                      },
                    ))
                        .toList(),
                  ),
                ],
              ),
            );
          }),

          // Search results
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(controller.errorMessage.value),
                );
              }

              if (controller.searchResults.isEmpty) {
                return const Center(
                  child: Text('Search for a word to get started'),
                );
              }

              return ListView.builder(
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final word = controller.searchResults[index];
                  final isFavorite =
                  controller.storageService.isFavorite(word);

                  return Card(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      title: Text(
                        word.word,
                        style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        word.meaning,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
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
          ),
        ],
      ),
    );
  }

  void _showWordDetails(BuildContext context, dynamic word,
      DictionarySearchController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          WordDetailsSheet(word: word, controller: controller),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}

class WordDetailsSheet extends StatelessWidget {
  final dynamic word;
  final DictionarySearchController controller;

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
        ],
      ),
    );
  }
}
