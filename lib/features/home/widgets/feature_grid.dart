import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/colors.dart';
import '../../favorites/screens/favorites_screen.dart';
import '../../history/screens/history_screen.dart';
import '../../requestWords/screens/request_word_screen.dart';
import '../../vocabulary/screens/vocabulary_screen.dart';
import '../../word_of_the_day/screens/word_of_day_screen.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Vocabulary', Icons.menu_book, AppColors.primary, "ذخیرہ الفاظ"),
      ('Word of the Day', Icons.sort_by_alpha, Colors.pink, "آج کا لفظ"),
      ('Favorites', Icons.favorite_border, Colors.orange, "پسندیدہ"),
      ('History', Icons.history, Colors.blue, "تاریخ"),
      ('Share App', Icons.share, Colors.deepPurple, "ایپ  شئیر"),
      ('Add More', Icons.add, AppColors.primary, "مزید شامل کریں"),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (_, i) {
        final item = items[i];

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            if (item.$1 == 'Vocabulary') {
              Get.to(() => const VocabularyScreen());

            } else if (item.$1 == 'Add More') {
              Get.to(() => RequestWordScreen());

            } else if (item.$1 == 'Favorites') {
              Get.to(() => FavoritesScreen());

            } else if (item.$1 == 'History') {
              Get.to(() => HistoryScreen());

            } else if (item.$1 == 'Share App') {
              Share.share(
                "Download Burushaski Dictionary:\n"
                "Learn Burushaski words easily with meanings and pronunciation.\n"
                    "https://play.google.com/store/apps/Burushaski Dictionary",
              );
            } else if (item.$1 == 'Word of the Day')
            {
              Get.to(() => WordOfDayScreen());
            }
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.$2, size: 48, color: item.$3),
                const SizedBox(height: 6),
                Text(item.$1, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(item.$4, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}