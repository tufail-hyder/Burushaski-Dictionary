import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../controllers/request_word_controller.dart';

class RequestWordScreen extends StatelessWidget {
  RequestWordScreen({super.key});

  final controller = Get.put(RequestWordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Request New Word', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            Text("Request a New Word", style: Theme.of(context).textTheme.headlineSmall,),

            const SizedBox(height: 10),

            Text("Can't find a word? Submit it with its meaning. After verification, it will be added to the dictionary.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: controller.wordController,
              decoration: InputDecoration(
                labelText: "Word",
                hintText: "Enter Burushaski Word",
                prefixIcon: const Icon(Icons.translate,color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller.meaningController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Meaning",
                hintText: "Enter Meaning",
                alignLabelWithHint: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: Icon(Icons.menu_book,color: AppColors.primary,),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(width: double.infinity, height: 55,

              child: Obx(
                    () => ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  onPressed: controller.isLoading.value ? null : controller.submitWord,

                  icon: controller.isLoading.value ? Container(
                    width: 22,
                    height: 22,
                    padding: const EdgeInsets.all(2),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ) : const Icon(Icons.send, color: Colors.white,),

                  label: Text(
                    controller.isLoading.value ? "Submitting..." : "Submit Request",
                    style: const TextStyle(color: Colors.white, fontSize: 17,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}