import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../controllers/onboarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();

    return Positioned(
      bottom: 110,
      right: 0,
      left: 0,
      child: Center(
        child: SmoothPageIndicator(
          controller: controller.pageController,
          count: 3,
          onDotClicked: controller.dotNavigatorClick,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.primary,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ),
    );
  }
}