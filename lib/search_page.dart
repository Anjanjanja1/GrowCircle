import 'dart:io';
import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'main_layout.dart';
import 'plant_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String selectedCategory = 'Alle';
  String selectedStadium = 'Alle';
  String selectedLichtbedarf = 'Alle';
  String searchQuery = '';
  final currentUser = dummyUsers.firstWhere((user) => user.id == 'u2');

  final List<String> categories = [
    'Alle',
    'Zimmerpflanze',
    'Kräuter',
    'Ableger',
    'Samen',
    'Gartenpflanze',
    'Sonstige',
  ];

  final List<String> stadiumOptionen = [
    'Alle',
    'Samen',
    'Ableger',
    'Jungpflanze',
    'Ausgewachsen',
  ];

  final List<String> lichtOptionen = [
    'Alle',
    'Viel',
    'Mittel',
    'Wenig',
  ];

  List<DummyPlant> get filteredPlants {
    return dummyPlants.where((plant) {
      final matchesCategory = selectedCategory == 'Alle' || plant.kategorie == selectedCategory;
      final matchesStadium = selectedStadium == 'Alle' || plant.pflanzenstadium == selectedStadium;
      final matchesLicht = selectedLichtbedarf == 'Alle' || plant.lichtbedarf == selectedLichtbedarf;
      final matchesSearch = plant.titel.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesCategory && matchesStadium && matchesLicht && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 1,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "🔍 Pflanze finden",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nach Titel suchen...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) => setState(() => searchQuery = value),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                onChanged: (value) => setState(() => selectedCategory = value!),
                decoration: InputDecoration(
                  labelText: "Kategorie",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedLichtbedarf,
                      items: lichtOptionen.map((licht) => DropdownMenuItem(value: licht, child: Text(licht))).toList(),
                      onChanged: (value) => setState(() => selectedLichtbedarf = value!),
                      decoration: InputDecoration(
                        labelText: "☀️ Lichtbedarf",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedStadium,
                      items: stadiumOptionen.map((stadium) => DropdownMenuItem(value: stadium, child: Text(stadium))).toList(),
                      onChanged: (value) => setState(() => selectedStadium = value!),
                      decoration: InputDecoration(
                        labelText: "🌱 Stadium",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: filteredPlants.isEmpty
                    ? const Center(child: Text("Keine passenden Angebote gefunden"))
                    : GridView.builder(
                        itemCount: filteredPlants.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          final plant = filteredPlants[index];
                          final isFavorite = currentUser.favoritePlantIds.contains(plant.id);
                          return GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PlantDetailPage(plant: plant))),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                      child: plant.bildPfad != null
                                          ? (plant.bildPfad!.startsWith('assets/')
                                              ? Image.asset(plant.bildPfad!, fit: BoxFit.cover, width: double.infinity)
                                              : Image.file(File(plant.bildPfad!), fit: BoxFit.cover, width: double.infinity))
                                          : const Icon(Icons.local_florist, size: 40),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            plant.titel,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.grey),
                                          onPressed: () => setState(() {
                                            isFavorite ? currentUser.favoritePlantIds.remove(plant.id) : currentUser.favoritePlantIds.add(plant.id);
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
