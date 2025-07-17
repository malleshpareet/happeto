import 'dart:async';
import 'package:flutter/material.dart';
import '../models/message_model.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  bool _isTyping = false;

  List<Message> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = Message(
      text: text,
      isUser: true,
      time: DateTime.now(),
      isSeen: true,
    );

    _messages.insert(0, userMessage);
    notifyListeners();

    _simulateVetReply();
  }

  void _simulateVetReply() {
    _isTyping = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      final vetMessage = Message(
        text: "Can you give me some more details?",
        isUser: false,
        time: DateTime.now(),
        isSeen: true,
      );

      _messages.insert(0, vetMessage);
      _isTyping = false;
      notifyListeners();
    });
  }
}
