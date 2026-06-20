import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../controllers/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();

    return Positioned(
      left: 0,
      right: 0,
      bottom: 30,
      child: Center(
        child: Obx(
              () => ElevatedButton(
            onPressed: controller.nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,

              shape: controller.currentPageIndex.value == 2
                  ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              )  : const CircleBorder(),

              minimumSize: controller.currentPageIndex.value == 2 ? const Size(380, 55) : const Size(50, 50),
              padding: controller.currentPageIndex.value == 2 ? const EdgeInsets.symmetric(horizontal: 20) : EdgeInsets.zero,),
            child: controller.currentPageIndex.value == 2 ? const Text("Get Started",
              style: TextStyle(color: Colors.white, fontSize: 15,)) : const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}