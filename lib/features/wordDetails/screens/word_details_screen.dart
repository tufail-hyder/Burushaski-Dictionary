import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../models/vocabulary_mode.dart';
import '../../favorites/controllers/favorites_controller.dart';
import '../controllers/word_detail_controller.dart';

class WordDetailScreen extends StatelessWidget {
  final VocabularyModel vocabulary;

  WordDetailScreen({
    super.key,
    required this.vocabulary,
  });

  final WordDetailController controller = Get.put(WordDetailController());
  final favoriteController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text('Word Details', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            final isFav = favoriteController.isFavorite(vocabulary.word,);

            return IconButton(

              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border, color: Colors.white,),
                onPressed: () {
                favoriteController.toggleFavorite(vocabulary,);
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
                const Expanded(child: Divider()),
                const SizedBox(width: 10),

                Text("Word", style: Theme.of(context).textTheme.headlineSmall,),

                const SizedBox(width: 10),
                const Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 20),

            /// WORD CARD

            Container(height: 100, width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(18),
              ),

              alignment: Alignment.center,

              child: Text(vocabulary.word, style: Theme.of(context).textTheme.titleMedium,),
            ),

            const SizedBox(height: 25),

            /// MEANING TITLE

            Row(
              children: [
                const Expanded(child: Divider()),
                const SizedBox(width: 10),

                Text("Meaning", style: Theme.of(context).textTheme.headlineSmall,),

                const SizedBox(width: 10),
                const Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 20),

            /// MEANING CARD

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(18),
              ),

              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(25),

                    child: Text(vocabulary.meaning, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium,),
                  ),

                  const Divider(height: 1),

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 8,
                    ),

                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,

                      children: [

                        IconButton(icon: const Icon(
                            Icons.volume_up,
                          ),
                          onPressed: () {
                            controller.speakWord(
                              vocabulary.word,
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.copy,
                          ),
                          onPressed: () {
                            controller.copyMeaning(
                              vocabulary.meaning,
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.share,
                          ),
                          onPressed: () {
                            controller.shareWord(
                              vocabulary,
                            );
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