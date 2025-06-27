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
  final stadiumOptionen = ['Samen', 'Ableger', 'Jungpflanze', 'Ausgewachsen'];
  final lichtOptionen = ['Viel', 'Mittel', 'Wenig'];
  final kategorie = [
    'Zimmerpflanze',
    'Kräuter',
    'Ableger',
    'Samen',
    'Gartenpflanze',
    'Sonstige',
  ];

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
      builder:
          (ctx) => AlertDialog(
            title: const Text("Eintrag löschen?"),
            content: const Text(
              "Bist du sicher, dass du dieses Angebot löschen möchtest?",
            ),
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
                child: const Text(
                  "Löschen",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void _showFullEditSheet() {
    final titleController = TextEditingController(text: widget.plant.titel);
    final beschreibungController = TextEditingController(
      text: widget.plant.beschreibung,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Eintrag bearbeiten",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Titel'),
                ),
                TextField(
                  controller: beschreibungController,
                  decoration: const InputDecoration(labelText: 'Beschreibung'),
                ),
                DropdownButtonFormField<String>(
                  value: widget.plant.kategorie,
                  items:
                      kategorie.map((cat) {
                        return DropdownMenuItem(value: cat, child: Text(cat));
                      }).toList(),
                  decoration: const InputDecoration(labelText: 'Kategorie'),
                  onChanged: (value) {
                    if (value != null)
                      setState(() => widget.plant.kategorie = value);
                  },
                ),
                DropdownButtonFormField<String>(
                  value: widget.plant.lichtbedarf,
                  items:
                      lichtOptionen.map((licht) {
                        return DropdownMenuItem(
                          value: licht,
                          child: Text(licht),
                        );
                      }).toList(),
                  decoration: const InputDecoration(labelText: 'Lichtbedarf'),
                  onChanged: (value) {
                    if (value != null)
                      setState(() => widget.plant.lichtbedarf = value);
                  },
                ),
                DropdownButtonFormField<String>(
                  value: widget.plant.pflanzenstadium,
                  items:
                      stadiumOptionen.map((stadium) {
                        return DropdownMenuItem(
                          value: stadium,
                          child: Text(stadium),
                        );
                      }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Pflanzenstadium',
                  ),
                  onChanged: (value) {
                    if (value != null)
                      setState(() => widget.plant.pflanzenstadium = value);
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.plant.titel = titleController.text;
                      widget.plant.beschreibung = beschreibungController.text;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pflanze aktualisiert")),
                    );
                  },
                  child: const Text("Speichern"),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  String getBenutzerName(String id) =>
      dummyUsers
          .firstWhere(
            (user) => user.id == id,
            orElse:
                () => DummyUser(
                  id: id,
                  name: 'Unbekannt',
                  email: 'unbekannt@example.com', // Dummy-Wert ergänzen
                  password: '', // Dummy-Wert ergänzen
                  favoritePlantIds: [], // Dummy-Wert ergänzen
                ),
          )
          .name;

  @override
  Widget build(BuildContext context) {
    final currentUser = dummyUsers.firstWhere(
      (user) => user.id == currentUserId,
    );
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
                          child:
                              widget.plant.bildPfad == null
                                  ? const Icon(Icons.local_florist, size: 60)
                                  : widget.plant.bildPfad!.startsWith("assets/")
                                  ? Image.asset(
                                    widget.plant.bildPfad!,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.file(
                                    File(widget.plant.bildPfad!),
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      if (widget.plant.benutzerId != currentUserId)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: IconButton(
                            icon: Icon(
                              isFavorit
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorit ? Colors.red : Colors.grey,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isFavorit) {
                                  currentUser.favoritePlantIds.remove(
                                    widget.plant.id,
                                  );
                                } else {
                                  currentUser.favoritePlantIds.add(
                                    widget.plant.id,
                                  );
                                }
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.plant.titel,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (widget.plant.benutzerId == currentUserId) ...[
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _showFullEditSheet(),
                          tooltip: "Bearbeiten",
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(context),
                          tooltip: "Löschen",
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),

                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: "🌿 Kategorie: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: widget.plant.kategorie),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: "☀️ Lichtbedarf: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: widget.plant.lichtbedarf),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: "🌱 Pflanzenstadium: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: widget.plant.pflanzenstadium),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: "👤 Anbieter*in: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: getBenutzerName(widget.plant.benutzerId),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    "📍 Standort",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  address == null
                      ? const CircularProgressIndicator()
                      : Text(
                        address!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),

                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 150,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: widget.plant.standort,
                          initialZoom: 15,
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.none,
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: const ['a', 'b', 'c'],
                            userAgentPackageName: 'com.example.grow_circle',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 40,
                                height: 40,
                                point: widget.plant.standort,
                                child: const Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    "📝 Beschreibung",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.plant.beschreibung,
                    style: const TextStyle(fontSize: 16),
                  ),
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
