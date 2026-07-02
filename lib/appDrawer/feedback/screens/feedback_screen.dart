import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../controllers/feedback_controller.dart';
import '../widgets/feedback_textfield.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  final controller = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Feedback", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [

              FeedbackTextField(hint: "Your Name (Optional)", controller: controller.nameController,),
              const SizedBox(height: 15),
              FeedbackTextField(hint: "Email (Optional)", controller: controller.emailController,),
              const SizedBox(height: 15),
              FeedbackTextField(hint: "Write your feedback...", controller: controller.feedbackController,
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your feedback";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(
                      () => ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,),
                    onPressed: controller.isLoading.value ? null : controller.submitFeedback,
                    child: controller.isLoading.value ? const CircularProgressIndicator(color: Colors.white,
                    ) : const Text("Submit Feedback",
                      style: TextStyle(color: Colors.white, fontSize: 16,),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}