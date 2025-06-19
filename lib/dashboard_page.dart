import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'main_layout.dart';
import 'dummy_data.dart';
import 'plant_detail_page.dart';
import 'dart:io';

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
  List<DummyPlant> _visiblePlants = [];
  Timer? _debounce;

  final LatLng _defaultLocation = LatLng(47.0707, 15.4395);

  LatLng get _effectiveCenter {
    return _currentPosition != null
        ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
        : _defaultLocation;
  }

  @override
  void initState() {
    super.initState();
    _determinePosition().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateVisiblePlants();
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _updateVisiblePlants() {
    try {
      final LatLngBounds? bounds = _mapController.camera.visibleBounds;
      if (bounds == null) return;

      setState(() {
        _visiblePlants =
            dummyPlants.where((plant) {
              return bounds.contains(plant.standort);
            }).toList();
      });
    } on StateError catch (e) {
      debugPrint("Map not ready yet, ignoring update: $e");
    }
  }

  void _onMapChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _updateVisiblePlants();
    });
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
    _mapController.move(_effectiveCenter, _currentZoom);
  }

  void _updateZoom(double zoomChange) async {
    final targetZoom = (_currentZoom + zoomChange).clamp(3.0, 18.0);
    final center = _mapController.camera.center;

    for (
      double z = _currentZoom;
      (zoomChange > 0 ? z < targetZoom : z > targetZoom);
      z += zoomChange > 0 ? 0.1 : -0.1
    ) {
      await Future.delayed(const Duration(milliseconds: 16));
      _mapController.move(center, z);
    }

    setState(() {
      _currentZoom = targetZoom;
      searchRadius = _zoomToRadius(_currentZoom);
    });
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

  void _goToCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.move(_effectiveCenter, _currentZoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final int gridImageCacheSize = (250 * pixelRatio).round();
    final int markerImageCacheSize = (100 * pixelRatio).round();

    return MainLayout(
      currentIndex: 0,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 600,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                          initialCenter: _effectiveCenter,
                                          initialZoom: _currentZoom,
                                          interactionOptions:
                                              const InteractionOptions(
                                                flags:
                                                    InteractiveFlag.pinchZoom |
                                                    InteractiveFlag.drag,
                                              ),
                                          onPositionChanged: (
                                            MapPosition position,
                                            bool hasGesture,
                                          ) {
                                            if (hasGesture &&
                                                position.zoom != null) {
                                              setState(() {
                                                _currentZoom = position.zoom!;
                                                searchRadius = _zoomToRadius(
                                                  _currentZoom,
                                                );
                                              });
                                            }
                                            _onMapChanged();
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
                                                point: _effectiveCenter,
                                                child: const Icon(
                                                  Icons.location_on,
                                                  color: Colors.red,
                                                  size: 36,
                                                ),
                                              ),
                                              ..._visiblePlants.map(
                                                (plant) => Marker(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  point: plant.standort,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  PlantDetailPage(
                                                                    plant:
                                                                        plant,
                                                                  ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            2,
                                                          ),
                                                      decoration:
                                                          const BoxDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    Colors
                                                                        .black26,
                                                                blurRadius: 6,
                                                                offset: Offset(
                                                                  0,
                                                                  2,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                      child: ClipOval(
                                                        child:
                                                            plant.bildPfad !=
                                                                    null
                                                                ? (plant.bildPfad!
                                                                        .startsWith(
                                                                          'assets/',
                                                                        ))
                                                                    ? Image.asset(
                                                                      plant
                                                                          .bildPfad!,
                                                                      fit:
                                                                          BoxFit
                                                                              .cover,
                                                                      cacheWidth:
                                                                          markerImageCacheSize,
                                                                    )
                                                                    : Image.file(
                                                                      File(
                                                                        plant
                                                                            .bildPfad!,
                                                                      ),
                                                                      fit:
                                                                          BoxFit
                                                                              .cover,
                                                                      cacheWidth:
                                                                          markerImageCacheSize,
                                                                    )
                                                                : const Icon(
                                                                  Icons
                                                                      .local_florist,
                                                                  size: 30,
                                                                ),
                                                      ),
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
                              right: 12,
                              bottom: 12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FloatingActionButton(
                                    mini: true,
                                    heroTag: 'zoom_in',
                                    backgroundColor: Colors.white,
                                    onPressed: () => _updateZoom(1),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  FloatingActionButton(
                                    mini: true,
                                    heroTag: 'zoom_out',
                                    backgroundColor: Colors.white,
                                    onPressed: () => _updateZoom(-1),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  FloatingActionButton(
                                    mini: true,
                                    heroTag: 'my_location',
                                    backgroundColor: Colors.white,
                                    onPressed: _goToCurrentLocation,
                                    child: const Icon(
                                      Icons.my_location,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  FloatingActionButton(
                                    mini: true,
                                    heroTag: 'search_area',
                                    backgroundColor: Colors.green,
                                    onPressed: () {
                                      _updateVisiblePlants();
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Angebote in diesem Bereich aktualisiert!',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
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
                                _effectiveCenter,
                                _currentZoom,
                              );
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _visiblePlants.isEmpty
                            ? "Keine Angebote in diesem Bereich"
                            : "Angebote in diesem Bereich (${_visiblePlants.length})",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // This is the performant, scrollable grid.
              // We add padding here to ensure it doesn't touch the screen edges.
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                sliver:
                    _visiblePlants.isEmpty
                        ? const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 150,
                            child: Center(
                              child: Text(
                                'Zoome heraus oder verschiebe die Karte, um mehr zu sehen.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        )
                        : SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 3 / 4,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final plant = _visiblePlants[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            PlantDetailPage(plant: plant),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 2,
                                color: Colors.green.shade100,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child:
                                          plant.bildPfad != null
                                              ? (plant.bildPfad!.startsWith(
                                                    'assets/',
                                                  ))
                                                  ? Image.asset(
                                                    plant.bildPfad!,
                                                    fit: BoxFit.cover,
                                                    cacheWidth:
                                                        gridImageCacheSize,
                                                  )
                                                  : Image.file(
                                                    File(plant.bildPfad!),
                                                    fit: BoxFit.cover,
                                                    cacheWidth:
                                                        gridImageCacheSize,
                                                    errorBuilder: (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return const Center(
                                                        child: Icon(
                                                          Icons.broken_image,
                                                          size: 40,
                                                        ),
                                                      );
                                                    },
                                                  )
                                              : Container(
                                                color: Colors.green.shade200,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.local_florist,
                                                    size: 40,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        plant.titel,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }, childCount: _visiblePlants.length),
                        ),
              ),
              // Add a final padding sliver at the bottom for spacing
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
