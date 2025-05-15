import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'main_layout.dart';

class OfferPage extends StatefulWidget {
  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  File? _image;
  final picker = ImagePicker();
  String _lichtbedarf = 'Mittel';
  String _giebebedarf = 'Regelmäßig';

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
                  child:
                      _image == null
                          ? const Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.grey,
                          )
                          : Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Titel
            const Text("Titel"),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'z.B. Monstera Ableger',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Kategorie Dropdown
            const Text("Kategorie"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: 'Zimmerpflanze',
              items:
                  ['Zimmerpflanze', 'Kräuter', 'Gartenpflanze', 'Sonstige']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (_) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
                    items:
                        ['Wenig', 'Mittel', 'Viel']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => _lichtbedarf = value!),
                    decoration: const InputDecoration(
                      labelText: '☀️ Lichtbedarf',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _giebebedarf,
                    items:
                        ['Selten', 'Regelmäßig', 'Häufig']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => _giebebedarf = value!),
                    decoration: const InputDecoration(
                      labelText: '💧 Gießbedarf',
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
              maxLength: 140,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Beschreibe deine Pflanze (max. 140 Zeichen)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Standort
            const Text("📍 Standort"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text("Standort nicht verfügbar"),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                // Dummy Standort aktualisieren Logik
              },
              icon: const Icon(Icons.location_on),
              label: const Text("Standort aktualisieren"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Button unten
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Angebot speichern (Dummy)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Angebot gespeichert")),
                  );
                },
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
