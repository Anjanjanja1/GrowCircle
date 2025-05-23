import 'package:flutter/material.dart';
import 'chat_list_page.dart';
import 'exchange_offers_page.dart'; // Neue englische Seite

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Inbox'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Messages'), Tab(text: 'Exchange Offers')],
          ),
        ),
        body: const TabBarView(
          children: [ChatListPage(), ExchangeOffersPage()],
        ),
      ),
    );
  }
}
