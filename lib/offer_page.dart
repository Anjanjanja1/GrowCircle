import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'main_layout.dart';
import 'dummy_data.dart'; //DUMMY LIST

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  File? _image;
  final picker = ImagePicker();

  final _titelController = TextEditingController();
  final _beschreibungController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _addressController = TextEditingController();

  String _lichtbedarf = 'Mittel';
  String _pflanzenstadium = 'Ausgewachsen';
  String _kategorie = 'Zimmerpflanze';

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _getCoordinatesFromAddress() async {
    final address = _addressController.text.trim();
    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte Adresse eingeben")),
      );
      return;
    }

    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        setState(() {
          _latitudeController.text = loc.latitude.toString();
          _longitudeController.text = loc.longitude.toString();
        });
      } else {
        throw Exception("Keine Koordinaten gefunden");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Adresse konnte nicht gefunden werden: $e")),
      );
    }
  }

  void _speichereAngebot() {
    final titel = _titelController.text.trim();
    final beschreibung = _beschreibungController.text.trim();
    final latStr = _latitudeController.text.trim();
    final lngStr = _longitudeController.text.trim();

    if (titel.isEmpty || latStr.isEmpty || lngStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte alle Pflichtfelder ausfüllen")),
      );
      return;
    }

    final double? lat = double.tryParse(latStr);
    final double? lng = double.tryParse(lngStr);
    if (lat == null || lng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ungültige Koordinaten")),
      );
      return;
    }

    final neuesPflanze = DummyPlant(
      titel: titel,
      kategorie: _kategorie,
      lichtbedarf: _lichtbedarf,
      pflanzenstadium: _pflanzenstadium,
      beschreibung: beschreibung,
      standort: LatLng(lat, lng),
      benutzerId: 'u1',
      bildPfad: _image?.path,
    );

    setState(() {
      dummyPlants.add(neuesPflanze);
      _titelController.clear();
      _beschreibungController.clear();
      _latitudeController.clear();
      _longitudeController.clear();
      _addressController.clear();
      _image = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pflanze hinzugefügt!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 2,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto-Upload
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: _image == null
                      ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                      : Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Titel
            const Text("Titel"),
            const SizedBox(height: 8),
            TextField(
              controller: _titelController,
              decoration: InputDecoration(
                hintText: 'z.B. Monstera Ableger',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),

            // Kategorie Dropdown
            const Text("Kategorie"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _kategorie,
              items: ['Zimmerpflanze', 'Kräuter', 'Ableger', 'Samen', 'Gartenpflanze', 'Sonstige']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => _kategorie = val!),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),

            // Pflegehinweise
            const Text("Pflegehinweise"),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _lichtbedarf,
                    items: ['Wenig', 'Mittel', 'Viel']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => _lichtbedarf = val!),
                    decoration: const InputDecoration(
                      labelText: '☀️ Lichtbedarf',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _pflanzenstadium,
                    items: ['Ableger', 'Jungpflanze', 'Ausgewachsen']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => _pflanzenstadium = val!),
                    decoration: const InputDecoration(
                      labelText: '🌱 Pflanzenstadium',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Beschreibung
            const Text("Beschreibung"),
            const SizedBox(height: 8),
            TextField(
              controller: _beschreibungController,
              maxLength: 140,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Beschreibe deine Pflanze (max. 140 Zeichen)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),

            const Text("📍 Standort"),
            const SizedBox(height: 8),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: "z.B. Graz, Hauptplatz",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _getCoordinatesFromAddress,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latitudeController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Breitengrad (Lat)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _longitudeController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Längengrad (Lng)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Button unten
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _speichereAngebot,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Tauschangebot erstellen"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}