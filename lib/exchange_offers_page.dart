import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'chat_data.dart';
import 'dummy_data.dart'; // für DummyUser und DummyPlant

class ExchangeOffersPage extends StatefulWidget {
  const ExchangeOffersPage({super.key});

  @override
  State<ExchangeOffersPage> createState() => _ExchangeOffersPageState();
}

class _ExchangeOffersPageState extends State<ExchangeOffersPage> {
  List<Map<String, String>> offers = [
    {
      'user': dummyUsers[0].name, // Anna
      'plant': dummyPlants[0].titel, // Monstera
      'image': dummyPlants[0].bildPfad!,
    },
    {
      'user': dummyUsers[1].name, // Lukas
      'plant': dummyPlants[1].titel, // Basilikum
      'image': dummyPlants[1].bildPfad!,
    },
    {
      'user': dummyUsers[0].name,
      'plant': dummyPlants[4].titel, // Lavendel
      'image': dummyPlants[4].bildPfad!,
    },
  ];

  final Set<String> accepted = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: offers.length,
      itemBuilder: (context, index) {
        final offer = offers[index];
        final user = offer['user']!;
        final plant = offer['plant']!;
        final image = offer['image']!;
        final isAccepted = accepted.contains(user + plant);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      image,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("$user möchte mit dir $plant tauschen"),
                  subtitle: const Text("Was möchtest du tun?"),
                ),
                const SizedBox(height: 8),
                if (!isAccepted)
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                        ),
                        onPressed: () {
                          setState(() {
                            accepted.add(user + plant);

                            // ✅ Chat dauerhaft hinzufügen
                            chatThreads.insert(
                              0,
                              ChatThread(
                                userName: user,
                                imageUrl: image,
                                messages: [
                                  ChatMessage(
                                    text:
                                        "Hi $user hier, danke für deine Annahme um meine Pflanze $plant zu tauschen 😊",
                                    isSentByUser: false,
                                  ),
                                ],
                              ),
                            );
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Tausch mit $user angenommen!"),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },

                        child: const Text("Zustimmen"),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            offers.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Anfrage von $user abgelehnt"),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text("Ablehnen"),
                      ),
                    ],
                  )
                else
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ChatPage(
                                  chat: ChatThread(
                                    userName: user,
                                    imageUrl: '', // optional: eigenes Bild
                                    messages: [
                                      ChatMessage(
                                        text:
                                            "Hi $user hier, danke für deine Annahme um meine Pflanze $plant zu tauschen 😊",
                                        isSentByUser: false,
                                      ),
                                    ],
                                  ),
                                ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chat),
                      label: const Text("Jetzt Chat starten"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
