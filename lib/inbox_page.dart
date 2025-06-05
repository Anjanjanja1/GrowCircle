import 'package:flutter/material.dart';
import 'chat_list_page.dart';
import 'exchange_offers_page.dart';
import 'main_layout.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 3,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            title: Row(
              children: [
                Image.asset('assets/images/plants/plant_logo.png', height: 36),
                const SizedBox(width: 8),
                const Text(
                  'GrowCircle',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            actions: const [
              Icon(Icons.settings),
              SizedBox(width: 12),
              Icon(Icons.person),
              SizedBox(width: 12),
            ],
            bottom: TabBar(
              labelColor: Color(0xFF1B5E20), // dunkelgrün aktiv
              unselectedLabelColor: Color(0xFF2E7D32), // mittelgrün inaktiv
              indicatorColor: Color(0xFF1B5E20), // Unterstreichung
              tabs: [
                const Tab(icon: Icon(Icons.chat), text: 'Chats'),
                Tab(
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(
                              255,
                              67,
                              227,
                              78,
                            ), // Grüner Punkt
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  text: 'Tauschanfragen',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [ChatListPage(), ExchangeOffersPage()],
          ),
        ),
      ),
    );
  }
}
