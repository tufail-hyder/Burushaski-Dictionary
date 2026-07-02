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
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        title: Text("Feedback", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Column(
                  children: [
                    CircleAvatar(radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.feedback_outlined, color: AppColors.primary, size: 35,),),
                    SizedBox(height: 10),
                    Text("We Value Your Feedback", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold,),),
                    SizedBox(height: 6),
                    Text("Help us improve the Burushaski Dictionary by sharing your suggestions, ideas, or reporting any issues.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, height: 1.5,),),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      FeedbackTextField(
                        hint: "Your Name (Optional)",
                        controller: controller.nameController,
                      ),

                      const SizedBox(height: 18),

                      FeedbackTextField(
                        hint: "Email (Optional)",
                        controller: controller.emailController,
                      ),

                      const SizedBox(height: 18),

                      FeedbackTextField(
                        hint: "Write your feedback...",
                        controller: controller.feedbackController,
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
                        height: 55,
                        child: Obx(
                              () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.submitFeedback,
                            child: controller.isLoading.value
                                ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                                : const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Submit Feedback",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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