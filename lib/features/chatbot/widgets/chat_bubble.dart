import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/colors.dart';
import '../../../models/chat_message_model.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    super.key,
    required this.message,
  });

  final ChatMessageModel message;

  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.isUser;
    final bool isDark = Get.isDarkMode;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          /// BOT AVATAR
          if (!isUser)
            CircleAvatar(
              radius: 18,
              child: Image.asset("assets/icons/ai.png", width: 30, height: 30,),
            ),

          if (!isUser) const SizedBox(width: 8),

          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primary : (isDark ? Colors.grey.shade50: Colors.grey.shade50),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft:
                  Radius.circular(isUser ? 18 : 5),
                  bottomRight:
                  Radius.circular(isUser ? 5 : 18),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: .05),
                    blurRadius: 5,
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  /// MESSAGE
                  isUser ? Text(message.message, style: const TextStyle(color: Colors.white, fontSize: 16,height: 0.8,),) : _formattedMessage(),

                  /// COPY SHARE SPEAK
                  if (!isUser)
                    Row(
                      children: [

                        IconButton(tooltip: "Copy", splashRadius: 20, icon: const Icon(Icons.copy, size: 18,),
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: message.message,),
                            );

                            Get.snackbar("Copied", "Message copied successfully", snackPosition: SnackPosition.BOTTOM,);
                          },
                        ),

                        IconButton(tooltip: "Share", splashRadius: 20,
                          icon: const Icon(Icons.share, size: 18,),
                          onPressed: () {
                            Share.share(message.message);
                          },
                        ),

                        IconButton(tooltip: "Speak", splashRadius: 18,
                          icon: const Icon(Icons.volume_up, size: 20,),
                          onPressed: () async {
                            await flutterTts.stop();

                            await flutterTts.setLanguage("en-US");

                            await flutterTts.speak(message.message,);
                          },
                        ),

                        const Spacer(),

                        Text(
                          _formatTime(message.time),
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),

                  if (isUser)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _formatTime(message.time),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }

  /// BOT RESPONSE FORMATTER

  Widget _formattedMessage() {
    final lines = message.message.split("\n\n");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {

        if (line.trim().isEmpty) {
          return const SizedBox(height: 8);
        }

        if (line.contains(":")) {

          final parts = line.split(":");

          final title = parts.first.trim();

          final value = parts.sublist(1).join("").trim();

          return Padding(
            padding:
            const EdgeInsets.only(bottom: 10),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  height: 1.5,
                ),
                children: [

                  TextSpan(text: "$title\n", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),
                  TextSpan(text: value,),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding:
          const EdgeInsets.only(bottom: 8),
          child: Text(line, style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5,
            ),
          ),
        );

      }).toList(),
    );
  }

  /// TIME

  String _formatTime(DateTime time) {
    int hour = time.hour;

    final minute =
    time.minute.toString().padLeft(2, "0");

    final amPm = hour >= 12 ? "PM" : "AM";

    if (hour > 12) hour -= 12;

    if (hour == 0) hour = 12;

    return "$hour:$minute $amPm";
  }
}