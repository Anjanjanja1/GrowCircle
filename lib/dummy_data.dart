// NOTE: This list is updated via OfferPage when the user adds new entries.
// Newly added plants with image file paths will use `Image.file(...)` rendering.

import 'package:latlong2/latlong.dart';

class DummyPlant {
  final String titel;
  final String kategorie;
  final String lichtbedarf;
  final String pflanzenstadium;
  final String beschreibung;
  final LatLng standort;
  final String benutzerId;
  final String? bildPfad;
  bool? istFavorit;

  DummyPlant({
    required this.titel,
    required this.kategorie,
    required this.lichtbedarf,
    required this.pflanzenstadium,
    required this.beschreibung,
    required this.standort,
    required this.benutzerId,
    this.bildPfad,
    this.istFavorit = false,
  });
}

class DummyUser {
  final String id;
  final String name;

  DummyUser({required this.id, required this.name});
}

// Dummy Benutzer
final List<DummyUser> dummyUsers = [
  DummyUser(id: 'u1', name: 'Anna'),
  DummyUser(id: 'u2', name: 'Lukas'),
];

// Dummy Pflanzen rund um Graz
final List<DummyPlant> dummyPlants = [
  DummyPlant(
    titel: 'Monstera',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Ableger',
    beschreibung: 'Schöne große Blätter',
    standort: LatLng(47.0707, 15.4395), // Zentrum Graz
    benutzerId: 'u1',
    bildPfad: 'assets/images/plants/monstera.jpg',
  ),
  DummyPlant(
    titel: 'Basilikum',
    kategorie: 'Kräuter',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ableger',
    beschreibung: 'Frischer Basilikum für deine Küche',
    standort: LatLng(47.0750, 15.4500), // Lendplatz
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/basilikum.jpg',
  ),
  DummyPlant(
    titel: 'Aloe Vera',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Sehr pflegeleicht und heilend',
    standort: LatLng(47.0670, 15.4300), // Jakominiplatz
    benutzerId: 'u1',
    bildPfad: 'assets/images/plants/aloe_vera.jpg',
  ),
  DummyPlant(
    titel: 'Minze',
    kategorie: 'Kräuter',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Ideal für Tee!',
    standort: LatLng(47.0735, 15.4420), // Uni Graz
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/minze.jpg',
  ),
  DummyPlant(
    titel: 'Lavendel',
    kategorie: 'Gartenpflanze',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung: 'Duftet wunderbar!',
    standort: LatLng(47.0690, 15.4600), // Murpark
    benutzerId: 'u1',
    bildPfad: 'assets/images/plants/lavendel.jpg',
  ),
  DummyPlant(
    titel: 'Efeutute',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Wenig',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung: 'Perfekt fürs Regal',
    standort: LatLng(47.0780, 15.4350), // Hauptbahnhof
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/efeutute.jpg',
  ),
];

// Dummy Pflanzen Profil - Meine Angebote
final List<DummyPlant> dummyOfferPlants = [
  DummyPlant(
    titel: 'Gummibaum',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung:
        'Robust und wunderbar anspruchslos - verzeiht einem wirklich alles 😄',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/gummibaum.jpg',
  ),
  DummyPlant(
    titel: 'Amaryllis',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Samen',
    beschreibung:
        'Habe die Samen von meiner eigenen Pflanze, die rot blüht. Tausche gerne gegen Kräuter.',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/amaryllis.jpg',
  ),
  DummyPlant(
    titel: 'Banane',
    kategorie: 'Exotisch',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Winterhart bis -15°C',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/banane.jpg',
  ),
  DummyPlant(
    titel: 'Feigenbaum',
    kategorie: 'Mediterran',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Habe den Baum aus dem Kroatien-Urlaub mitgenommen!',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/feigenbaum.jpg',
  ),
];
