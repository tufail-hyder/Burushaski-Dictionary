import 'package:flutter/material.dart';
import 'package:burushashki_dictionary/core/constants/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../appDrawer/widgets/app_drawer.dart';
import '../../chatbot/screens/chat_screen.dart';
import '../../search/controllers/search_controller.dart';
import '../widgets/dictionary_header.dart';
import '../widgets/feature_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    Get.put(DictionarySearchController(), permanent: true);
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(280),
        child: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          automaticallyImplyLeading: false,

          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.notes, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          title: Text('Dictionary', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
          centerTitle: true,
          flexibleSpace: const DictionaryHeader(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Get.to(() => ChatScreen());
                },
                child: CircleAvatar(
                  radius: 16,
                  child: Image.asset("assets/icons/ai.png", width: 30, height: 30,),
                ),
              ),
            ),

          ],
        ),
      ),

      body: const FeatureGrid(),
    );
  }
}