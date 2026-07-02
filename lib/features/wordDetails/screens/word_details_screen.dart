import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../models/vocabulary_mode.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../../history/controllers/history_controller.dart';
import '../controllers/word_detail_controller.dart';

class WordDetailScreen extends StatelessWidget {
  final VocabularyModel vocabulary;

  WordDetailScreen({
    super.key,
    required this.vocabulary,
  });
  final historyController = Get.put(HistoryController());
  final favoriteController = Get.put(FavoritesController());
  final WordDetailController controller = Get.put(WordDetailController());
  final bool isDark = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      historyController.addHistory(vocabulary);
    });
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade100,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text("Word Details", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600,),
        ),
        leading: IconButton( icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20,),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            final isFav =
            favoriteController.isFavorite(vocabulary.word);

            return IconButton(
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.white,),
              onPressed: () {
                favoriteController.toggleFavorite(vocabulary);
              },
            );
          }),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// WORD TITLE
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),

                Text("Word", style: Theme.of(context).textTheme.headlineSmall,),
                const SizedBox(width: 10),

                Expanded(
                  child: Divider(color: Colors.grey,),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// WORD CARD

            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,

                child: Text(vocabulary.word, style: Theme.of(context).textTheme.titleMedium,),
              ),
            ),

            const SizedBox(height: 30),

            /// Meaning Title

            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey,),
                ),
                const SizedBox(width: 10),

                Text("Meaning", style: Theme.of(context).textTheme.headlineSmall,),

                const SizedBox(width: 10),

                Expanded(
                  child: Divider(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Meaning Card

            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(35),
                    child: Text(vocabulary.meaning, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium,),
                  ),

                  Divider(color: Colors.grey, height: 3),

                  Padding(padding: const EdgeInsets.symmetric(vertical: 8,),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,

                      children: [

                        IconButton(
                          icon: Icon(Icons.volume_up, color: Theme.of(context).iconTheme.color,),
                          onPressed: () {
                            controller.speakWord(
                              vocabulary.meaning,
                            );
                          },
                        ),

                        IconButton(
                          icon: Icon(Icons.copy, color: Theme.of(context).iconTheme.color,),
                          onPressed: () {controller.copyMeaning(vocabulary.meaning,);
                          },
                        ),

                        IconButton(
                          icon: Icon(Icons.share, color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () {controller.shareWord(vocabulary,);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}