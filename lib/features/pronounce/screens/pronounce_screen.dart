import 'package:flutter/material.dart';

class PronounceScreen extends StatelessWidget {
  const PronounceScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Pronounce')),
      body: const Center(child: Text('Pronunciation screen')),
    );
  }
}