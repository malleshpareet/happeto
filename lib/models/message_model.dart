enum MessageType { text, image, audio }

class Message {
  final String text; // can also be image/audio file path
  final bool isUser;
  final DateTime time;
  final bool isSeen;
  final MessageType type;

  Message({
    required this.text,
    required this.isUser,
    required this.time,
    this.isSeen = false,
    this.type = MessageType.text,
  });
}
