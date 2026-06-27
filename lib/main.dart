import 'package:burushashki_dictionary/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/theme/custom_themes/text_theme.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  /// GetX Local Storage
  await GetStorage.init();

  runApp(const BurushaskiDictionaryApp());
}

class BurushaskiDictionaryApp extends StatelessWidget {
  const BurushaskiDictionaryApp({super.key});

  @override
  Widget build(BuildContext context)
  {

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: AppTextTheme.lightTextTheme,),
        darkTheme: ThemeData(textTheme: AppTextTheme.darkTextTheme,),
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
    );
  }
}