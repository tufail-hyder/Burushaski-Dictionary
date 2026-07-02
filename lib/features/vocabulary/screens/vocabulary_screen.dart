import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/constants/colors.dart';
import '../../wordDetails/screens/word_details_screen.dart';
import '../controllers/vocabulary_controller.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VocabularyController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }
        if (controller.words.isEmpty) {
          return const Center(child: Text('No words found'));
        }

        // local filter text (UI level, no controller change required)
        return _VocabularyListWithSearch(controller: controller);
      }),
    );
  }
}

class _VocabularyListWithSearch extends StatefulWidget {
  final VocabularyController controller;
  const _VocabularyListWithSearch({required this.controller});

  @override
  State<_VocabularyListWithSearch> createState() =>
      _VocabularyListWithSearchState();
}

class _VocabularyListWithSearchState extends State<_VocabularyListWithSearch> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allWords = widget.controller.words;

    final filtered = allWords.where((item) {
      final q = _query.trim().toLowerCase();
      if (q.isEmpty) return true;

      return item.word.toLowerCase().contains(q) ||
          item.meaning.toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() => _query = value);
            },
            decoration: InputDecoration(
              hintText: 'Search word or meaning...',
              prefixIcon: const Icon(Iconsax.search_normal_copy,color: AppColors.primary,),
              suffixIcon: _query.isEmpty ? null : IconButton(
                icon: const Icon(Icons.close,color: AppColors.primary,),
                onPressed: () {
                  _searchController.clear();
                  setState(() => _query = '');
                },
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.35)),
                    ),
               focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
                 ),
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('No matching words'))
              : ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            itemCount: filtered.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (_, index) {
              final item = filtered[index];

              return Card(
                child: ListTile(
                  title: Text(
                    item.word,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.meaning),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Get.to(() => WordDetailScreen(vocabulary: item));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}