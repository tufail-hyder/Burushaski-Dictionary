import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller =
  Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("Settings", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500,
        ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20,),
          onPressed: () => Get.back(),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Obx(
                  () => SwitchListTile(
                    activeThumbColor: AppColors.primary,
                secondary: const Icon(Icons.dark_mode),
                title: const Text("Dark Mode"),
                subtitle: const Text("Enable dark theme"),
                value: controller.darkMode.value,
                onChanged: controller.changeDarkMode,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Obx(
                  () => SwitchListTile(
                    activeThumbColor: AppColors.primary,
                secondary: const Icon(Icons.notifications_active),
                title: const Text("Daily Notification"),
                subtitle: const Text("Receive Word of the Day"),
                value: controller.notification.value,
                onChanged: controller.changeNotification,
              ),
            ),
          ),


          const SizedBox(height: 20),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("App Version"),
              subtitle: Text("Version 1.0.0"),
            ),
          ),

          const SizedBox(height: 10),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Clear Cache"),
              subtitle: const Text("Remove temporary files"),
              onTap: controller.clearCache,
            ),
          ),
        ],
      ),
    );
  }
}