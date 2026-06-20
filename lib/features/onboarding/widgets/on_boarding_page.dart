import 'package:flutter/material.dart';
import '../../../core/constants/sizes.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        children: [
          Image.asset(
            image,
            width: size.width * 0.8,
            height: size.height * 0.60,
          ),

          const SizedBox(height: 12),

          Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(subTitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}