import 'package:burushashki_dictionary/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/theme/custom_themes/text_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  final box = GetStorage();

  final bool isDark = box.read("darkMode") ?? false;

  runApp(
    BurushaskiDictionaryApp(isDark: isDark),
  );
}

class BurushaskiDictionaryApp extends StatelessWidget {
  final bool isDark;

  const BurushaskiDictionaryApp({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, textTheme: AppTextTheme.lightTextTheme,),
      darkTheme: ThemeData(brightness: Brightness.dark, textTheme: AppTextTheme.darkTextTheme,),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home: const SplashScreen(),
    );
  }
}