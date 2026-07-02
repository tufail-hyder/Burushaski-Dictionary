import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/colors.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  final String email = "burushaskidictionary@gmail.com";
  final String phone = "+92 340 0189816";

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        title: Text("Contact Us", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const CircleAvatar(
              radius: 35,
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.support_agent,
                color: Colors.white,
                size: 45,
              ),
            ),

            const SizedBox(height: 20),
            const Text("Get in Touch", style: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold,),),
            const SizedBox(height: 10),

            Text("If you have any questions, suggestions, or need assistance, please feel free to contact us.", textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            _contactCard(
              icon: Icons.email_outlined,
              title: "Email",
              subtitle: email,
              onTap: () => _launch("mailto:$email"),
            ),

            const SizedBox(height: 15),

            _contactCard(
              icon: Icons.phone,
              title: "Phone",
              subtitle: phone,
              onTap: () => _launch("tel:$phone"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
      ),
    );
  }
}