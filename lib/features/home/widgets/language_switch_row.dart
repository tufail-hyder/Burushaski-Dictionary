import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../controllers/language_controller.dart';

class LanguageSwitchRow extends StatelessWidget {
  const LanguageSwitchRow({super.key});

  @override
  Widget build(BuildContext context) {//

    return Obx(
          () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12, height: 28),
            Text('Burushaski', style: const TextStyle(color: Colors.white, fontSize: 16),),

            const Spacer(),
              Icon(Icons.swap_horiz, color: Colors.white, size: 28,),

            const Spacer(),
            const SizedBox(width: 12, height: 32),

            Text("English", style: const TextStyle(color: Colors.white, fontSize: 16),),
          ],
        ),
      ),
    );
  }
}