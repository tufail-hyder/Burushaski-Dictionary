import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../search/controllers/search_controller.dart';
import '../../wordDetails/screens/word_details_screen.dart';

class SearchCard extends StatelessWidget {
  SearchCard({super.key});

  final DictionarySearchController controller =
  Get.find<DictionarySearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Box
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

        const SizedBox(height: 8),

        Obx(() {
          if (controller.suggestions.isEmpty) {
            return const SizedBox();
          }

          return Container(
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: controller.suggestions.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = controller.suggestions[index];

                return ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(
                    item.word,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    item.meaning,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    Get.to(() => WordDetailScreen(vocabulary: item,
                      ),
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