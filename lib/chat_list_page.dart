import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'chat_data.dart'; // ← Importiere dein Dummy-Datenmodell

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final Set<String> gelesen = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.separated(
        itemCount: chatThreads.length,
        separatorBuilder:
            (context, index) => const Divider(indent: 72, height: 0),
        itemBuilder: (context, index) {
          final chat = chatThreads[index];
          final name = chat.userName;
          final lastMessage =
              chat.messages.isNotEmpty
                  ? chat.messages.last.text
                  : 'Keine Nachrichten';
          final isUnread =
              ['Lena Pflanze', 'Sandra Grün'].contains(name) &&
              !gelesen.contains(name);

          return Dismissible(
            key: Key(name),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) {
              setState(() {
                chatThreads.removeAt(index);
                gelesen.remove(name);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Chat mit $name gelöscht')),
              );
            },
            child: Container(
              color: isUnread ? const Color(0xFFF1F8E9) : Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                leading: Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(chat.imageUrl),
                    ),
                    if (isUnread)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(
                  name,
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  setState(() {
                    gelesen.add(name);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChatPage(chat: chat)),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
