import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() =>
      _TypingIndicatorState();
}

class _TypingIndicatorState
    extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildDot(double interval) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {

        double value =
        (_controller.value - interval).clamp(0.0, 1.0);

        double opacity =
        value < 0.5 ? value * 2 : (1 - value) * 2;

        return Opacity(
          opacity: opacity.clamp(0.2, 1.0),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: CircleAvatar(
              radius: 4,
              backgroundColor: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          CircleAvatar(
            radius: 18,
            child: Image.asset("assets/icons/ai.png", width: 30, height: 30,),
          ),

          const SizedBox(width: 6),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:
              BorderRadius.circular(10),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                buildDot(0.0),

                buildDot(0.2),

                buildDot(0.4),

              ],
            ),
          ),
        ],
      ),
    );
  }
}