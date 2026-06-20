import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/widgets/search_card.dart';
import '../controllers/search_controller.dart';
import 'word_details_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final controller = Get.put(DictionarySearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            // 🔍 SEARCH INPUT ONLY
            SearchCard(),

            const SizedBox(height: 10),

            // 📌 SUGGESTIONS AREA (SAFE HERE)
            Expanded(
              child: Obx(() {
                if (controller.suggestions.isEmpty) {
                  return const Center(
                    child: Text("Start typing to search words..."),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.suggestions.length,
                  itemBuilder: (context, index) {
                    final word = controller.suggestions[index];

                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.search),
                        title: Text(word),

                        onTap: () {
                          Get.to(
                                () => WordDetailScreen(word: word, meaning: '',),
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}