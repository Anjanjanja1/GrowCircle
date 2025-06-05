import 'package:flutter/material.dart';
import 'main_layout.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 16),
            const Text(
              '📖 Hilfe & Tipps',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Hier kannst du Pflanzen tauschen, verschenken oder neue Schätze entdecken – alles in deiner Nähe!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildStep(
              emoji: '🏠',
              title: 'Startseite (Home)',
              description:
                  'Auf der Karte findest du Pflanzenangebote in deiner Umgebung. Zoome rein oder raus, um den Radius zu ändern.',
            ),
            _buildStep(
              emoji: '🔍',
              title: 'Suche',
              description:
                  'Nutze Filter wie Kategorie oder Lichtbedarf, um genau das zu finden, was du suchst.',
            ),
            _buildStep(
              emoji: '➕',
              title: 'Anbieten',
              description:
                  'Du hast Ableger, Samen oder Topfpflanzen übrig? Füge sie hinzu und teile sie mit anderen!',
            ),
            _buildStep(
              emoji: '💬',
              title: 'Mitteilungen',
              description:
                  'Nachrichten und Tausch-Anfragen findest du hier. Bleib im Austausch!',
            ),
            _buildStep(
              emoji: '❤️',
              title: 'Favoriten',
              description:
                  'Markiere interessante Pflanzen und finde sie schnell wieder.',
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🌟 Tipp:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Aktiviere deinen Standort, um Angebote in deiner Nähe zu sehen.\n\nDu kannst aber auch ohne Standort loslegen – Graz wird standardmäßig verwendet.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Happy Growing! 🌱',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({
    required String emoji,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
