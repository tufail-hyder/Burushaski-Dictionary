// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class WordOfDayScreen extends StatelessWidget {
//   WordOfDayScreen({super.key});
//
//   final SearchController controller = Get.find<SearchController>();
//
//   @override
//   Widget build(BuildContext context) {
//     final word = controller.getRandomWord();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Word of the Day")),
//       body: word == null
//           ? const Center(child: Text("No word available"))
//           : Center(
//         child: Card(
//           margin: const EdgeInsets.all(20),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(word.text,
//                     style: const TextStyle(
//                         fontSize: 26, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//                 Text(word.meaning),
//                 const SizedBox(height: 20),
//                 IconButton(
//                   icon: const Icon(Icons.volume_up),
//                   onPressed: () => controller.speak(word.text),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }