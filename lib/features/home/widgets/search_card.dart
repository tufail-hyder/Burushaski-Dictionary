import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../search/controllers/search_controller.dart';
import '../../search/screens/word_details_screen.dart';

class SearchCard extends StatelessWidget {
  SearchCard({super.key});

  final controller = Get.find<DictionarySearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // 🔍 SEARCH BOX//
        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            onChanged: controller.onSearchChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Iconsax.search_normal_copy),
              suffixIcon: Icon(Icons.mic_none_outlined),
              labelText: "Search a word...",
            ),
          ),
        ),

        const SizedBox(height: 6),

        // 📌 SUGGESTIONS (SAFE VERSION)
        Obx(() {
          if (controller.suggestions.isEmpty) {
            return const SizedBox();
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            constraints: const BoxConstraints(
              maxHeight: 250,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),

            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: controller.suggestions.length,
              itemBuilder: (context, index) {
                final word = controller.suggestions[index];

                return ListTile(
                  dense: true,
                  leading: const Icon(Icons.search),
                  title: Text(word),

                  onTap: () {
                    FocusScope.of(context).unfocus();

                    Get.to(() => WordDetailScreen(word: word, meaning: '',),
                    );
                  },
                );
              },
            ),
          );
        }),
      ],
    );
  }
}