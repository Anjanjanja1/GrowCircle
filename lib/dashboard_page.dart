import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double searchRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: Icon einfügen!
        automaticallyImplyLeading: false, // Zurück-Pfeil wird unterdrückt
        title: const Text('GrowCircle'),
        backgroundColor: Colors.green,
        actions: const [
          Icon(Icons.settings),
          SizedBox(width: 12),
          Icon(Icons.person),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map View Placeholder
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Kartenansicht", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 4),
                    Text("4 Pflanzen im Umkreis von 10km"),
                    Text(
                      "(Hier würde die Karte angezeigt werden)",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Suchfilter
            const Text(
              "Suchfilter",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Suche nach Pflanzen...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Slider
            Text("Suchradius: ${searchRadius.toStringAsFixed(0)} km"),
            Slider(
              value: searchRadius,
              min: 1,
              max: 50,
              divisions: 49,
              label: "${searchRadius.toStringAsFixed(0)} km",
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  searchRadius = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Angebote
            const Text(
              "Angebote in deiner Nähe",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade200,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.local_florist, size: 40),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Pflanze ${1}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Suche"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Anbieten",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favoriten",
          ),
        ],
        onTap: (index) {
          // Prototyp: kein Navigation nötig, aber du kannst hier später Seiten verknüpfen
        },
      ),
    );
  }
}
