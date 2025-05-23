import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'main_layout.dart';
import 'dummy_data.dart';
import 'plant_detail_page.dart';
import 'dart:io';
import 'inbox_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double searchRadius = 10.0;
  int currentIndex = 0; // Seitenindex
  Position? _currentPosition;
  final MapController _mapController = MapController();
  double _currentZoom = 13.0;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    setState(() => _currentPosition = position);
  }

  double _radiusToZoom(double radiusKm) {
    if (radiusKm <= 0.5) return 17;
    if (radiusKm <= 1) return 16;
    if (radiusKm <= 2) return 15;
    if (radiusKm <= 3) return 14.5;
    if (radiusKm <= 5) return 14;
    if (radiusKm <= 7) return 13.5;
    if (radiusKm <= 10) return 13;
    if (radiusKm <= 15) return 12.5;
    if (radiusKm <= 20) return 12;
    if (radiusKm <= 30) return 11;
    return 10;
  }

  void _updateZoom(double zoomChange) {
    setState(() {
      _currentZoom += zoomChange;
      _currentZoom = _currentZoom.clamp(3.0, 18.0);
      searchRadius = _zoomToRadius(_currentZoom);
      if (_currentPosition != null) {
        _mapController.move(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          _currentZoom,
        );
      }
    });
  }

  double _zoomToRadius(double zoom) {
    if (zoom >= 17) return 0.5;
    if (zoom >= 16) return 1;
    if (zoom >= 15) return 2;
    if (zoom >= 14.5) return 3;
    if (zoom >= 14) return 5;
    if (zoom >= 13.5) return 7;
    if (zoom >= 13) return 10;
    if (zoom >= 12.5) return 15;
    if (zoom >= 12) return 20;
    if (zoom >= 11) return 30;
    return 50;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      child: SafeArea(
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
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 730,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:
                        _currentPosition == null
                            ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 8),
                                  Text("Standort wird ermittelt..."),
                                ],
                              ),
                            )
                            : FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                initialCenter: LatLng(
                                  _currentPosition!.latitude,
                                  _currentPosition!.longitude,
                                ),
                                initialZoom: _currentZoom,
                                interactionOptions: const InteractionOptions(
                                  flags:
                                      InteractiveFlag.pinchZoom |
                                      InteractiveFlag.drag,
                                ),
                                onPositionChanged: (
                                  MapPosition position,
                                  bool hasGesture,
                                ) {
                                  if (hasGesture && position.zoom != null) {
                                    setState(() {
                                      _currentZoom = position.zoom!;
                                      searchRadius = _zoomToRadius(
                                        _currentZoom,
                                      );
                                    });
                                  }
                                },
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  subdomains: const ['a', 'b', 'c'],
                                  userAgentPackageName:
                                      'com.example.grow_circle',
                                ),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      width: 40.0,
                                      height: 40.0,
                                      point: LatLng(
                                        _currentPosition!.latitude,
                                        _currentPosition!.longitude,
                                      ),
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 36,
                                      ),
                                    ),
                                    ...dummyPlants.map(
                                      (plant) => Marker(
                                        width: 50.0,
                                        height: 50.0,
                                        point: plant.standort,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 6,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.local_florist,
                                            color: Colors.green,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                  ),
                ),
                if (_currentPosition != null)
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _updateZoom(1),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => _updateZoom(-1),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text("Suchradius: ${searchRadius.toStringAsFixed(1)} km"),
            Slider(
              value: searchRadius,
              min: 0.5,
              max: 50,
              divisions: 99,
              label: "${searchRadius.toStringAsFixed(1)} km",
              activeColor: Colors.green,
              onChanged: (double value) {
                setState(() {
                  searchRadius = value;
                  _currentZoom = _radiusToZoom(searchRadius);
                  if (_currentPosition != null) {
                    _mapController.move(
                      LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      _currentZoom,
                    );
                  }
                });
              },
            ),
            const SizedBox(height: 20),

            // Angebote
            const Text(
              "Angebote in deiner Nähe",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dummyPlants.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final plant = dummyPlants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetailPage(plant: plant),
                      ),
                    );
                  },
                  child: Container(
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
                            child:
                                plant.bildPfad != null
                                    ? (plant.bildPfad!.startsWith('assets/')
                                        ? Image.asset(
                                          plant.bildPfad!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                        : Image.file(
                                          File(plant.bildPfad!),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return const Center(
                                              child: Icon(
                                                Icons.broken_image,
                                                size: 40,
                                                color: Colors.blueGrey,
                                              ),
                                            );
                                          },
                                        ))
                                    : const Center(
                                      child: Icon(
                                        Icons.local_florist,
                                        size: 40,
                                      ),
                                    ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            plant.titel,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
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
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InboxPage()),
            );
          }
          // Hier kannst du später weitere Navigationen für andere Indices ergänzen
        },
      ),
    );
  }
}
