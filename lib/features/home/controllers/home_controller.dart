import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/word_model.dart';
import '../../../services/api_service.dart';
import '../../../services/local_storage_service.dart';
import '../../favorites/screens/favorites_screen.dart';
import '../../history/screens/history_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../vocabulary/screens/vocabulary_screen.dart';

class HomeController extends GetxController {
  final apiService = ApiService();
  final storageService = LocalStorageService();

  Rx<Word?> wordOfTheDay = Rx<Word?>(null);
  RxBool isLoadingWord = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWordOfTheDay();
  }

  /// Fetch word of the day
  Future<void> fetchWordOfTheDay() async {
    isLoadingWord.value = true;
    try {
      final word = await apiService.getWordOfTheDay();
      wordOfTheDay.value = word;
    } catch (e) {
      print('Error fetching word of the day: $e');
    } finally {
      isLoadingWord.value = false;
    }
  }

  void onFeatureTap(String title) {
    switch (title) {
      case 'Vocabulary':
        Get.to(() => const VocabularyScreen());
        break;
      case 'Word of the Day':
        Get.to(() => const WordOfTheDayScreen());
        break;
      case 'Favorites':
        Get.to(() => const FavoritesScreen());
        break;
      case 'History':
        Get.to(() => const HistoryScreen());
        break;
      case 'Share App':
        _shareApp();
        break;
      case 'Add More':
        Get.to(() => const SettingsScreen());
        break;
      default:
        Get.snackbar('Info', 'Coming soon');
    }
  }

  /// Share app functionality
  void _shareApp() {
    Get.snackbar(
      'Share App',
      'App sharing functionality to be implemented',
      duration: const Duration(seconds: 2),
    );
    // You can use share_plus package here
    // Share.share('Check out Burushashki Dictionary: https://...');
  }
}

// Placeholder screen for Word of the Day
class WordOfTheDayScreen extends StatelessWidget {
  const WordOfTheDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Word of the Day'),
      ),
      body: Obx(() {
        if (controller.isLoadingWord.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final word = controller.wordOfTheDay.value;
        if (word == null) {
          return const Center(child: Text('No word available today'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                word.word,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                word.meaning,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (word.example != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Example:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  word.example!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}
