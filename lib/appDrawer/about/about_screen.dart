import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../core/constants/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        title:  Text("About Us", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            /// App Logo Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Image.asset("assets/logos/app_logo.png", height: 120,),
                    const SizedBox(height: 16),
                    const Text("Burushaski - English Dictionary", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
                    const SizedBox(height: 8),
                    Text("Version 1.0.0", style: TextStyle(color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// About
            _section(title: "About the App",
              content: "Burushaski-English Dictionary is designed to preserve and promote the Burushaski language by providing meanings, pronunciation, and chatbot. It helps students, researchers, and language learners understand Burushaski vocabulary in an easy and accessible way.",),
            const SizedBox(height: 15),

            /// Mission
            _section(title: "Our Mission",
              content: "Our mission is to make learning Burushaski simple and accessible while helping preserve this unique language for future generations through modern technology.",),
            const SizedBox(height: 15),

            /// Features
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Features",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.primary,
                        fontFamily: "TimesRomanFont",
                      ),
                    ),

                    const SizedBox(height: 15),

                    _featureItem(Icons.search, "Search Burushaski words"),
                    _featureItem(Icons.translate, "View word meanings"),
                    _featureItem(Icons.volume_up, "Pronunciation support"),
                    _featureItem(Icons.smart_toy, "AI Chat Bot"),
                    _featureItem(Icons.favorite_border, "Favorite words"),
                    _featureItem(Icons.history, "Search history"),
                    _featureItem(Icons.add_box_outlined, "Request new words"),
                    _featureItem(Icons.share, "Share words with friends"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "© 2026 Burushaski Dictionary\nAll Rights Reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary, fontFamily: "TimesRomanFont"),),
            const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            content,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              fontFamily: 'TimesRomanFont',
            ),
          ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget _featureItem(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: "TimesRomanFont",
              height: 1.6,
            ),
          ),
        ),
      ],
    ),
  );
}