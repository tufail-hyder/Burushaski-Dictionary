import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';

class FeedbackController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final feedbackController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> submitFeedback() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar("Thank You", "Your feedback has been submitted successfully.", snackPosition: SnackPosition.BOTTOM, backgroundColor: AppColors.primary);

    nameController.clear();
    emailController.clear();
    feedbackController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    feedbackController.dispose();
    super.onClose();
  }
}