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
        child: Column(
          children: const [
            TabBar(
              labelColor: Color(0xFF1B5E20),
              unselectedLabelColor: Color(0xFF2E7D32),
              indicatorColor: Color(0xFF1B5E20),
              tabs: [
                Tab(icon: Icon(Icons.chat), text: 'Chats'),
                Tab(
                  icon: Stack(
                    children: [
                      Icon(Icons.notifications),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Color.fromARGB(255, 67, 227, 78),
                        ),
                      ),
                    ],
                  ),
                  text: 'Exchange Requests',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [ChatListPage(), ExchangeOffersPage()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
