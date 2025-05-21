import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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

  @override
  Widget build(BuildContext context) {
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
                  // Bild + Herz-Button
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
                      Positioned(
                        top: 12,
                        right: 12,
                        child: IconButton(
                          icon: Icon(
                            widget.plant.istFavorit == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                widget.plant.istFavorit == true
                                    ? Colors.red
                                    : Colors.grey,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.plant.istFavorit =
                                  !(widget.plant.istFavorit ?? false);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: Text(
                      widget.plant.titel,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                        TextSpan(text: widget.plant.benutzerId),
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
                    child: Container(
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
                  const Text(
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
            // Zurück Button
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
