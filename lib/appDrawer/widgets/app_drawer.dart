import 'package:burushashki_dictionary/appDrawer/about/about_screen.dart';
import 'package:burushashki_dictionary/features/requestWords/screens/request_word_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/colors.dart';
import '../feedback/screens/feedback_screen.dart';
import '../settings/screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: (size.height * 0.93).clamp(240.0, 1000.0),
      child: Drawer(
        width: (size.width * 0.67).clamp(240.0, 320.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              height: 279,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/logos/app_logo.png"),
                    height: 140,
                  ),
                  const SizedBox(height: 12),
                  Text("Burushaski - English", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 16),),
                  const SizedBox(height: 4),
                  Text("Dictionary", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 16),),
                ],
              ),
            ),

            const SizedBox(height: 8),

            _tile(context, Icons.home, "Home", () => Get.back()),
            _tile(context, Iconsax.add_square, "Request New Word", () { Get.to(() => RequestWordScreen());},),
            _tile(context, Icons.settings, "Settings", () { Get.to(() => SettingsScreen());},),
            _tile(context, Icons.feedback_rounded, "Feedback Us", () {Get.to(() => FeedbackScreen());},),
            _tile(context, Icons.share, "Share App", () {Share.share("Download Burushaski Dictionary:\n"
                  "Learn Burushaski words easily with meanings and pronunciation.\n"
                  "https://play.google.com/store/apps/Burushaski Dictionary",
            );}),
            _tile(context, Icons.info, "About Us", () {Get.to(()=>AboutScreen());}),
            _tile(context, Icons.phone, "Contact Us", () {}),
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
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge,),
      onTap: onTap,
    );
  }
}