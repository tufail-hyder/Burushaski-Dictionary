import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../features/home/controllers/theme_controller.dart';
import '../features/settings/screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return SizedBox(
      width: 260,
      height: 600,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primary),
              child: Center(
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage("assets/logos/app_logo.png"),
                      height: 90,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "English - Burushaski",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Dictionary",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),

            Obx(
                  () => SwitchListTile(
                activeThumbColor: AppColors.primary,
                title: Text(
                  "Dark Mode",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                value: themeController.isDark.value,
                onChanged: (val) => themeController.toggleTheme(),
              ),
            ),

            _tile(context, Icons.home, "Home", () => Get.back()),
            _tile(context, Icons.settings, "Settings",
                    () => Get.to(() => const SettingsScreen())),
            _tile(context, Icons.star_rate, "Rate Us", () {}),
            _tile(context, Icons.share, "Share App", () {}),
            _tile(context, Icons.info, "About Us", () {}),
            _tile(context, Icons.exit_to_app, "Exit", () {
              Get.defaultDialog(
                title: "Exit App",
                middleText: "Do you want to exit?",
                textConfirm: "Yes",
                textCancel: "No",
                onConfirm: () => Get.back(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _tile(
      BuildContext context,
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      onTap: onTap,
    );
  }
}