import 'package:burushashki_dictionary/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'language_switch_row.dart';
import 'search_card.dart';

class DictionaryHeader extends StatelessWidget {
  const DictionaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 90, 16, 0),
      child: Container(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: dark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            LanguageSwitchRow(),
            SizedBox(height: 18),
            SearchCard(),
          ],
        ),
      ),
    );
  }
}