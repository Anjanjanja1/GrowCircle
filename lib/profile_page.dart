import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main_layout.dart';
import 'plant_detail_page.dart';
import 'dummy_data.dart'; //DUMMY LIST

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  int currentIndex = 4; // Seitenindex
  String savedName = '';
  String savedSlogan = '';
  String savedLocation = '';

  final picker = ImagePicker();
  final nameController = TextEditingController();
  final sloganController = TextEditingController();
  final locationController = TextEditingController();
  final filteredPlants =
      dummyPlants.where((plant) => plant.benutzerId == 'u2').toList();

  bool isEditing = false; // Zustand für Bearbeitbarkeit

  Future<void> _pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _toggleEditing() {
    if (isEditing) {
      // Speichern der Daten
      print("Name: ${nameController.text}");
      print("Über mich: ${sloganController.text}");
      print("Standort: ${locationController.text}");
    }

    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    sloganController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Startwerte Profil
    nameController.text = 'Clara Müller';
    sloganController.text = 'Pflanzensammlerin mit grünem Daumen :)';
    locationController.text = 'Graz-Jakomini';
  }

  void _saveProfile() {
    setState(() {
      savedName = nameController.text;
      savedSlogan = sloganController.text;
      savedLocation = locationController.text;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Änderungen gespeichert!')));
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 4, // Seitenindex
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profilbild
            GestureDetector(
              onTap: isEditing ? _pickProfileImage : null,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    _profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage(
                              'assets/images/plants/profile_img.jpg',
                            )
                            as ImageProvider,
                backgroundColor: Colors.green.shade100,
                child:
                    isEditing
                        ? const Icon(
                          Icons.camera_alt,
                          size: 32,
                          color: Colors.white,
                        )
                        : null,
              ),
            ),
            const SizedBox(height: 16),

            // Feld Name
            TextField(
              controller: nameController,
              enabled: isEditing,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Über Mich Feld
            TextField(
              controller: sloganController,
              enabled: isEditing,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Über mich",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Feld Standort
            TextField(
              controller: locationController,
              enabled: isEditing,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Standort",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Speichern Button
            ElevatedButton(
              onPressed: _toggleEditing,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(isEditing ? "Speichern" : "Bearbeiten"),
            ),
            const SizedBox(height: 24),

            // Meine Angebote
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Meine Tausch-Angebote",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredPlants.length, // Anzahl Angebote
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final plant = filteredPlants[index];
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
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
