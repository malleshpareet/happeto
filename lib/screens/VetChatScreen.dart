import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';

class VetChatScreen extends StatefulWidget {
  final String vetName;
  final String vetImage;

  const VetChatScreen({
    super.key,
    required this.vetName,
    required this.vetImage,
  });

  @override
  State<VetChatScreen> createState() => _VetChatScreenState();
}

class _VetChatScreenState extends State<VetChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showEmojiPicker = false;

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
      if (_showEmojiPicker) {
        _focusNode.unfocus();
      } else {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  void _onEmojiSelected(String emoji) {
    setState(() {
      _controller.text += emoji;
    });
  }

  final List<String> emojis = [
    '😀', '😁', '😂', '🤣', '😅', '😊', '😍',
    '😘', '😎', '😢', '😭', '😡', '👍', '🙏',
    '💪', '👏', '🤔', '🥺', '🙌', '🎉', '❤️',
  ];

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(widget.vetImage), radius: 16),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.vetName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Text("Online", style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.event_note_outlined),
            onPressed: () {
              // TODO: Navigate to appointment screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Text("Today • 04:51 PM", style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final msg = chatProvider.messages[index];
                final align = msg.isUser ? Alignment.centerRight : Alignment.centerLeft;
                final color = msg.isUser ? Colors.blue[100] : Colors.white;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  alignment: align,
                  child: Row(
                    mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!msg.isUser)
                        CircleAvatar(radius: 16, backgroundImage: AssetImage(widget.vetImage)),
                      if (!msg.isUser) const SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(msg.text),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${msg.time.hour.toString().padLeft(2, '0')}:${msg.time.minute.toString().padLeft(2, '0')}",
                                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                                  ),
                                  if (msg.isUser)
                                    Icon(
                                      msg.isSeen ? Icons.done_all : Icons.done,
                                      size: 14,
                                      color: msg.isSeen ? Colors.blue : Colors.grey,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          if (chatProvider.isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(radius: 12, backgroundImage: AssetImage(widget.vetImage)),
                  const SizedBox(width: 8),
                  const Text("Dr. Spoorthi is typing...",
                      style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  onPressed: _toggleEmojiPicker,
                ),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () {
                    // TODO: Pick/send image
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // TODO: Record/send audio
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        hintText: "Write something...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (text) {
                        chatProvider.sendMessage(text);
                        _controller.clear();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: () {
                      chatProvider.sendMessage(_controller.text);
                      _controller.clear();
                    },
                  ),
                ),
              ],
            ),
          ),

          Offstage(
            offstage: !_showEmojiPicker,
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: GridView.builder(
                itemCount: emojis.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onEmojiSelected(emojis[index]),
                    child: Center(
                      child: Text(
                        emojis[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
