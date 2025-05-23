import 'package:flutter/material.dart';
import 'chat_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy-Daten lokal innerhalb build()
    const List<Map<String, String>> dummyChats = [
      {'name': 'Lena Pflanze', 'lastMessage': 'Kannst du morgen tauschen?'},
      {'name': 'Tom Gärtner', 'lastMessage': 'Ich habe noch Basilikum übrig!'},
      {'name': 'Sandra Grün', 'lastMessage': 'Super, dann bis Freitag!'},
      {'name': 'Paul Bio', 'lastMessage': 'Gibt es noch Tomaten?'},
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: dummyChats.length,
        itemBuilder: (context, index) {
          final chat = dummyChats[index];
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(chat['name']!),
            subtitle: Text(chat['lastMessage']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            },
          );
        },
      ),
    );
  }
}
