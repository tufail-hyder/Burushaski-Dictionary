import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../home/widgets/search_card.dart';
import '../controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DictionarySearchController());

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SearchCard(),
        ),
      ),
    );
  }
}