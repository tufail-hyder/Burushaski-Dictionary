import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/image_strings.dart';
import '../../../core/constants/texts.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/on_boarding_dot_navigation.dart';
import '../widgets/on_boarding_next_button.dart';
import '../widgets/on_boarding_page.dart';
import '../widgets/on_boarding_skip.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(image: AppImages.onBoardingImage1, title: AppTexts.onboardingTitle1, subTitle: AppTexts.onboardingSubTitle1,),
              OnBoardingPage(image: AppImages.onBoardingImage2, title: AppTexts.onboardingTitle2, subTitle: AppTexts.onboardingSubTitle2,),
              OnBoardingPage(image: AppImages.onBoardingImage3, title: AppTexts.onboardingTitle3, subTitle: AppTexts.onboardingSubTitle3,),
            ],
          ),

          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}