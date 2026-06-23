import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../controllers/word_controller.dart';

class WordDetailScreen extends StatelessWidget {
  final String word;
  final String meaning;

  WordDetailScreen({
    super.key,
    required this.word,
    required this.meaning,
  });

  final favController = Get.put(FavoritesController());
  final controller = Get.put(WordController());

  @override
  Widget build(BuildContext context)
  {
    controller.fetchWord(word);
    return Scaffold(
      appBar: AppBar(
        title: Text(word),
        actions: [
          Obx(() {
            final isFav = favController.isFavorite(word);

            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : Colors.white,
              ),
              onPressed: () => favController.toggleFavorite(word),
            );
          }),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔤 WORD
            Text(
              word,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 📖 MEANING
            Text(
              "Meaning",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              meaning,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}