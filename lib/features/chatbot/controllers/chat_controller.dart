import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/chat_message_model.dart';
import '../../../services/dictionary_api.dart';

class ChatController extends GetxController {
  /// TextField Controller
  final TextEditingController messageController =
  TextEditingController();

  /// Scroll Controller
  final ScrollController scrollController =
  ScrollController();

  /// Messages List
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;

  /// Loading
  final RxBool isTyping = false.obs;

  @override
  void onInit() {
    super.onInit();

    /// Welcome Message
    messages.add(
      ChatMessageModel(
        message:
        "👋 Hello!\n\nI am your Burushaski AI Assistant.\n\nAsk me anything about Burushaski words.",
        isUser: false,
      ),
    );
  }

  /// Send Message
  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    /// User Message
    messages.add(
      ChatMessageModel(
        message: text,
        isUser: true,
      ),
    );

    messageController.clear();

    _scrollToBottom();

    isTyping.value = true;

    try {
      final reply = await DictionaryApi.chat(text);

      messages.add(
        ChatMessageModel(
          message: reply,
          isUser: false,
        ),
      );
    } catch (e) {
      messages.add(
        ChatMessageModel(
          message:
          "Something went wrong.\nPlease try again.",
          isUser: false,
        ),
      );
    }

    isTyping.value = false;

    _scrollToBottom();
  }

  /// Scroll to Latest Message
  void _scrollToBottom() {
    Future.delayed(
      const Duration(milliseconds: 200),
          () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}