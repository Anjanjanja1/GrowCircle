import 'dart:io';
import 'package:flutter/material.dart';
import 'main_layout.dart';
import 'plant_detail_page.dart';
import 'dummy_data.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DummyUser currentUser =
        dummyUsers.firstWhere((user) => user.email == 'clara@example.com');

    final favoritePlants = dummyPlants
        .where((plant) => currentUser.favoritePlantIds.contains(plant.id))
        .toList();

    return MainLayout(
      currentIndex: 4,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '❤️ Meine Favoriten',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: favoritePlants.isEmpty
                    ? const Center(child: Text("Keine Favoriten gespeichert"))
                    : GridView.builder(
                        itemCount: favoritePlants.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          final plant = favoritePlants[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PlantDetailPage(plant: plant),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: plant.bildPfad != null
                                          ? Image.asset(
                                              plant.bildPfad!,
                                              fit: BoxFit.cover,
                                            )
                                          : const Icon(
                                              Icons.local_florist,
                                              size: 40,
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
                                      overflow: TextOverflow.ellipsis,
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
