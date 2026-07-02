import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import '../controllers/chat_controller.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/typing_indicator.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController controller =
  Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        title:  Text("Burushaski AI", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.5,),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.white,),
          onPressed: () => Get.back(),
        ),
      ),

      body: Column(
        children: [

          /// Messages
          Expanded(
            child: Obx(() {

              return ListView.builder(
                controller:
                controller.scrollController,
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 10,
                ),

                itemCount:
                controller.messages.length,

                itemBuilder: (context, index) {

                  return ChatBubble(message: controller.messages[index],);
                },
              );
            }),
          ),

          /// Typing Indicator
          Obx(() {

            if (!controller.isTyping.value) {
              return const SizedBox();
            }
            return const TypingIndicator();
          }),

          /// Input Area
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.black.withValues(alpha: .05),
                    blurRadius: 5,
                  )
                ],
              ),

              child: Row(
                children: [

                  /// TextField

                  Expanded(
                    child: TextField(controller: controller.messageController,
                      textInputAction: TextInputAction.send,
                      minLines: 1,
                      maxLines: 5,
                      onSubmitted: (_) {
                        controller.sendMessage();
                      },

                      decoration: InputDecoration(
                        hintText: "Ask anything...",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(38),),
                        contentPadding:
                        const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// Send Button

                  CircleAvatar(radius: 18, backgroundColor: AppColors.primary,

                    child: IconButton(
                      onPressed: () {
                        controller.sendMessage();
                      },
                      icon: const Icon(Icons.send, color: Colors.white,size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}