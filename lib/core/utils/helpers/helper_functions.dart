import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHelperFunctions {
  AppHelperFunctions._();

  /* -------------------- SNACK BAR -------------------- */
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


  /* -------------------- NAVIGATION -------------------- */
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  /* -------------------- TRUNCATE TEXT -------------------- */
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /* -------------------- DARK MODE CHECK -------------------- */
  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /* -------------------- SCREEN SIZE -------------------- */
  static Size screenSize()
  {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenWidth()
  {
    return MediaQuery.of(Get.context!).size.width;
  }

  static double screenHeight()
  {
    return MediaQuery.of(Get.context!).size.height;
  }
}
