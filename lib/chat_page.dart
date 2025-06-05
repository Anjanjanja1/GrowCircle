import 'package:flutter/material.dart';
import 'main_layout.dart';
import 'chat_data.dart'; // ← Importiere deine ChatThread-Klasse

class ChatPage extends StatefulWidget {
  final ChatThread chat;

  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        widget.chat.messages.add(ChatMessage(text: text, isSentByUser: true));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = widget.chat.messages;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 8),
            CircleAvatar(backgroundImage: NetworkImage(widget.chat.imageUrl)),
            const SizedBox(width: 12),
            Text(
              widget.chat.userName,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment:
                      msg.isSentByUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 280),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color:
                          msg.isSentByUser
                              ? Colors.green.shade100
                              : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(msg.isSentByUser ? 16 : 0),
                        bottomRight: Radius.circular(msg.isSentByUser ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(msg.text, style: const TextStyle(fontSize: 16)),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Nachricht schreiben...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
