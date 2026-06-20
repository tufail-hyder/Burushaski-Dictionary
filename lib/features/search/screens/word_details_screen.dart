// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/search_controller.dart';
//
// class WordDetailScreen extends StatelessWidget {
//   WordDetailScreen({super.key});
//
//   final SearchControllerX controller = Get.find<SearchControllerX>();
//
//   @override
//   Widget build(BuildContext context) {
//     final word = Get.arguments;
//
//     return Scaffold(
//       appBar: AppBar(title: Text(word.text)),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(word.text,
//                 style: const TextStyle(
//                     fontSize: 30, fontWeight: FontWeight.bold)),
//
//             const SizedBox(height: 10),
//             Text(word.meaning),
//
//             const Spacer(),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.volume_up),
//                   onPressed: () => controller.speak(word.text),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.copy),
//                   onPressed: () => controller.copyWord(word.text),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.share),
//                   onPressed: () => controller.shareWord(word.text),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.favorite),
//                   onPressed: () => controller.toggleFavourite(word),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }