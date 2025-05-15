import 'package:flutter/material.dart';
import 'offer_page.dart';
import 'main_layout.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double searchRadius = 10.0;
  int currentIndex = 0; // Seitenindex

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      // appBar: AppBar(
      //   // TODO: Icon einfügen!
      //   automaticallyImplyLeading: false, // Zurück-Pfeil wird unterdrückt
      //   title: const Text('GrowCircle'),
      //   backgroundColor: Colors.green,
      //   actions: const [
      //     Icon(Icons.settings),
      //     SizedBox(width: 12),
      //     Icon(Icons.person),
      //     SizedBox(width: 12),
      //   ],
      // ),
      child: SingleChildScrollView(
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
              itemCount: 6,
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
    );
  }
}
