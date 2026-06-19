import 'package:burushashki_dictionary/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/theme/custom_themes/text_theme.dart';
import 'features/home/controllers/theme_controller.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ThemeController(), permanent: true);

  /// Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// GetX Local Storage
  await GetStorage.init();

  runApp(const BurushaskiDictionaryApp());
}

class BurushaskiDictionaryApp extends StatelessWidget {
  const BurushaskiDictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
          () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: AppTextTheme.lightTextTheme,),
        darkTheme: ThemeData(textTheme: AppTextTheme.darkTextTheme,),
        themeMode: themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}