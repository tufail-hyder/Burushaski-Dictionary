import 'package:burushashki_dictionary/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../search/controllers/search_controller.dart';
import '../../search/screens/search_screen.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key});

  @override
  Widget build(BuildContext context)
  {
    final dark = AppHelperFunctions.isDarkMode(context);
    final c = Get.find<DictionarySearchController>();

    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12),

        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: TextField(
        onChanged: c.searchWord,
        onTap: () {
          Get.to(() => const SearchScreen());
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Iconsax.search_normal_copy,size: 22,),
          suffixIcon: Icon(Icons.mic_none_outlined,size: 24),
          labelText: "Search a word...",
        ),
      ),
    );
  }
}