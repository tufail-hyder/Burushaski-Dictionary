import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../controllers/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();

    return Positioned(
      top: 40,
      right: 10,
      child: TextButton(
        onPressed: controller.skipPage,
        child: const Text("Skip", style: TextStyle(fontSize: 14, color: AppColors.primary)),
      ),
    );
  }
}