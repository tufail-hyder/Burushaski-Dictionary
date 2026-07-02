import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/colors.dart';

class SettingsController extends GetxController {
  final box = GetStorage();

  RxBool darkMode = false.obs;
  RxBool notification = true.obs;

  @override
  void onInit() {
    super.onInit();

    darkMode.value = box.read("darkMode") ?? false;
    notification.value = box.read("notification") ?? true;
  }

  void changeDarkMode(bool value) {
    darkMode.value = value;

    box.write("darkMode", value);

    Get.changeThemeMode(
      value ? ThemeMode.dark : ThemeMode.light,
    );

    Get.snackbar("Settings", value ? "Dark Mode Enabled" : "Dark Mode Disabled", snackPosition: SnackPosition.BOTTOM,backgroundColor: AppColors.primary);
  }

  void changeNotification(bool value) {
    notification.value = value;

    box.write("notification", value);

    Get.snackbar("Settings", value ? "Notification Enabled" : "Notification Disabled", snackPosition: SnackPosition.BOTTOM,backgroundColor: AppColors.primary);
  }

  void clearCache() {
    Get.defaultDialog(
      title: "Clear Cache",
      middleText: "Are you sure you want to clear cache?",
      textCancel: "Cancel",
      textConfirm: "Clear",
      onConfirm: () {
        Get.back();

        Get.snackbar(
          "Success",
          "Cache cleared successfully.",
            backgroundColor: AppColors.primary,
            snackPosition: SnackPosition.BOTTOM
        );
      },
    );
  }
}