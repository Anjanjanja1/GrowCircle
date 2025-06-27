import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dummy_data.dart';
import 'main_layout.dart';
import 'package:geocoding/geocoding.dart';

class PlantDetailPage extends StatefulWidget {
  final DummyPlant plant;
  const PlantDetailPage({super.key, required this.plant});

  @override
  State<PlantDetailPage> createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
  final String currentUserId = 'u2';
  String? address;

  @override
  void initState() {
    super.initState();
    _resolveAddress();
  }

  Future<void> _resolveAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.plant.standort.latitude,
        widget.plant.standort.longitude,
        localeIdentifier: "de",
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        setState(() {
          address = "${p.street}, ${p.postalCode} ${p.locality}";
        });
      }
    } catch (e) {
      setState(() {
        address = "Adresse konnte nicht ermittelt werden";
      });
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Eintrag löschen?"),
        content: const Text("Bist du sicher, dass du dieses Angebot löschen möchtest?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () {
              setState(() => dummyPlants.remove(widget.plant));
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Eintrag gelöscht")),
              );
            },
            child: const Text("Löschen", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String getBenutzerName(String id) => dummyUsers.firstWhere(
      (user) => user.id == id,
      orElse: () => DummyUser(
        id: id,
        name: 'Unbekannt',
        email: 'unbekannt@example.com', // Dummy-Wert ergänzen
        password: '', // Dummy-Wert ergänzen
        favoritePlantIds: [], // Dummy-Wert ergänzen
      ),
    ).name;


  @override
  Widget build(BuildContext context) {
    final currentUser = dummyUsers.firstWhere((user) => user.id == currentUserId);
    bool isFavorit = currentUser.favoritePlantIds.contains(widget.plant.id);

    return MainLayout(
      currentIndex: 0,
      child: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 320,
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          child: widget.plant.bildPfad == null
                              ? const Icon(Icons.local_florist, size: 60)
                              : widget.plant.bildPfad!.startsWith("assets/")
                                  ? Image.asset(widget.plant.bildPfad!, fit: BoxFit.cover)
                                  : Image.file(File(widget.plant.bildPfad!), fit: BoxFit.cover),
                        ),
                      ),
                      if (widget.plant.benutzerId != currentUserId)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: IconButton(
                            icon: Icon(isFavorit ? Icons.favorite : Icons.favorite_border,
                                color: isFavorit ? Colors.red : Colors.grey, size: 30),
                            onPressed: () {
                              setState(() {
                                if (isFavorit) {
                                  currentUser.favoritePlantIds.remove(widget.plant.id);
                                } else {
                                  currentUser.favoritePlantIds.add(widget.plant.id);
                                }
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(widget.plant.titel,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text("🌿 Kategorie: ${widget.plant.kategorie}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("☀️ Lichtbedarf: ${widget.plant.lichtbedarf}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("🌱 Pflanzenstadium: ${widget.plant.pflanzenstadium}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("👤 Anbieter*in: ${getBenutzerName(widget.plant.benutzerId)}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  Text("📍 Standort", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 6),
                  address == null
                      ? const CircularProgressIndicator()
                      : Text(address!, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 150,
                    child: FlutterMap(
                      options: MapOptions(initialCenter: widget.plant.standort, initialZoom: 15),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            point: widget.plant.standort,
                            child: const Icon(Icons.location_pin, color: Colors.red, size: 36),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text("📝 Beschreibung", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(widget.plant.beschreibung, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 4,
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
