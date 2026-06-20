import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Vocabulary', Icons.menu_book, AppColors.primary,"ذخیرہ الفاظ"),
      ('Word of the Day', Icons.sort_by_alpha, Colors.pink,"آج کا لفظ"),
      ('Favorites', Icons.favorite_border, Colors.orange,"پسندیدہ"),
      ('History', Icons.history, Colors.blue,"تاریخ"),
      ('Share App', Icons.share, Colors.deepPurple,"ایپ  شئیر"),
      ('Add More', Icons.add, AppColors.primary,"مزید شامل کریں"),
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