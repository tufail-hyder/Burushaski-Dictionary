import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Obx(
            () => SwitchListTile(
          title: const Text('Dark Mode'),
          value: themeController.isDark.value,
          onChanged: (_) => themeController.toggleTheme(),
        ),
      ),
    );
  }
}