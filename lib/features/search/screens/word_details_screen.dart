import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/colors.dart';
import '../../../models/vocabulary_mode.dart';

class WordDetailScreen extends StatefulWidget {
  final VocabularyModel vocabulary;

  const WordDetailScreen({
    super.key,
    required this.vocabulary,
  });

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {

  final FlutterTts flutterTts = FlutterTts();

  Future<void> speakWord() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(widget.vocabulary.word);
  }

  void copyMeaning() {
    Clipboard.setData(
      ClipboardData(text: widget.vocabulary.meaning),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Meaning copied"),
      ),
    );
  }

  void shareWord() {
    Share.share(
      "${widget.vocabulary.word}\n\n${widget.vocabulary.meaning}",
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Word Details', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Divider(thickness: 1.5,),
                ),
                const SizedBox(width: 12),

                Text(" Word ", style: Theme.of(context).textTheme.headlineSmall,),

                const SizedBox(width: 12),

                const Expanded(
                  child: Divider(thickness: 1.5,),
                ),

              ],
            ),

            const SizedBox(height: 18),

            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),

              alignment: Alignment.center,
              child: Text(widget.vocabulary.word, style: Theme.of(context).textTheme.titleMedium),
            ),

            const SizedBox(height: 18),

            /// Meaning
            Row(children: [
                const Expanded(child: Divider()),
                const SizedBox(width: 12),

              Text(" Meaning ", style: Theme.of(context).textTheme.headlineSmall,),

              const SizedBox(width: 12),
              const Expanded(child: Divider()),

              ],
            ),

            const SizedBox(height: 18),

            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(

                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 47,
                    ),

                    alignment: Alignment.center,

                    child: Text(widget.vocabulary.meaning, style: Theme.of(context).textTheme.titleMedium),
                  ),

                  const Divider(height: 1),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [

                      IconButton(
                        icon: const Icon(Icons.volume_up, size: 22),
                        onPressed: speakWord,
                      ),

                      IconButton(
                        icon: const Icon(Icons.copy, size: 22),
                        onPressed: copyMeaning,
                      ),

                      IconButton(
                        icon: const Icon(Icons.share, size: 22),
                        onPressed: shareWord,
                      ),

                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}