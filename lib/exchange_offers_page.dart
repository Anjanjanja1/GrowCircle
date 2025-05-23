import 'package:flutter/material.dart';

class ExchangeOffersPage extends StatelessWidget {
  const ExchangeOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = [
      {'title': 'Tomatoes for Zucchini', 'status': 'Request sent'},
      {'title': 'Herb bundle available', 'status': 'Pending'},
      {'title': 'Pear exchange', 'status': 'Accepted'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: offers.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final offer = offers[index];
        return ListTile(
          leading: const Icon(Icons.sync_alt, color: Colors.green),
          title: Text(offer['title']!),
          subtitle: Text("Status: ${offer['status']}"),
        );
      },
    );
  }
}
