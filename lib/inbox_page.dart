import 'package:flutter/material.dart';
import 'chat_list_page.dart';
import 'exchange_offers_page.dart';
import 'main_layout.dart'; // Neue englische Seite

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 3,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Tab Leiste
            Container(
              color: Colors.white,
              child: const TabBar(
                labelColor: Colors.green,
                indicatorColor: Colors.green,
                tabs: [Tab(text: 'Nachrichten'), Tab(text: 'Tausch-Angebote')],
              ),
            ),
            const Expanded(
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
