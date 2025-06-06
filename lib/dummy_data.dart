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
    istFavorit: true,
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
    istFavorit: false,
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
    istFavorit: true,
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
    istFavorit: true,
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
    istFavorit: false,
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
    istFavorit: false,
  ),
  DummyPlant(
    titel: 'Drachenbaum',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Pflegeleichter Hingucker mit langen, schmalen Blättern.',
    standort: LatLng(47.0725, 15.4480), // Schlossberg
    benutzerId: 'u1',
    bildPfad: 'assets/images/plants/drachenbaum.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    titel: 'Petersilie',
    kategorie: 'Kräuter',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ableger',
    beschreibung: 'Wächst schnell nach – ideal für frische Küche.',
    standort: LatLng(47.0742, 15.4444), // Stadtpark
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/petersilie.jpg',
    istFavorit: true,
  ),
  DummyPlant(
    titel: 'Thymian',
    kategorie: 'Kräuter',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Würzig duftender Küchenklassiker.',
    standort: LatLng(47.0701, 15.4499), // Murinsel
    benutzerId: 'u1',
    bildPfad: 'assets/images/plants/thymian.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    titel: 'Kaktus',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung: 'Mag Sonne und braucht kaum Wasser.',
    standort: LatLng(47.0682, 15.4381), // Kunsthaus Graz
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/kaktus.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    titel: 'Tomate',
    kategorie: 'Gartenpflanze',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Trägt bereits kleine Früchte.',
    standort: LatLng(47.0665, 15.4573), // Augarten
    benutzerId: 'u1',
    bildPfad: 'assets/images/plants/tomate.jpg',
    istFavorit: true,
  ),
  DummyPlant(
    titel: 'Oregano',
    kategorie: 'Kräuter',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung: 'Wächst kräftig – ideal für Pizza-Fans!',
    standort: LatLng(47.0697, 15.4407), // Hauptplatz
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/oregano.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    titel: 'Zimmerlinde',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Große weiche Blätter, wächst schnell.',
    standort: LatLng(47.0658, 15.4455), // Jakoministraße
    benutzerId: 'u1',
    bildPfad: 'assets/images/plants/zimmerlinde.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    titel: 'Zitronenmelisse',
    kategorie: 'Kräuter',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Ableger',
    beschreibung: 'Beruhigend und lecker im Tee.',
    standort: LatLng(47.0711, 15.4520), // Griesplatz
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/zitronenmelisse.jpg',
    istFavorit: true,
  ),
  DummyPlant(
    titel: 'Salbei',
    kategorie: 'Kräuter',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung: 'Aromatisch, gut für Hals & Stimme.',
    standort: LatLng(47.0760, 15.4370), // Messe Graz
    benutzerId: 'u1',
    bildPfad: 'assets/images/plants/salbei.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    titel: 'Chili',
    kategorie: 'Gartenpflanze',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Scharfer Genuss direkt vom Balkon.',
    standort: LatLng(47.0720, 15.4542), // Plabutsch
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/chili.jpg',
    istFavorit: true,
  ),
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
    kategorie: 'Samen',
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
    kategorie: 'Sonstige',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Winterhart bis -15°C',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/banane.jpg',
  ),
  DummyPlant(
    titel: 'Feigenbaum',
    kategorie: 'Sonstige',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Habe den Baum aus dem Kroatien-Urlaub mitgenommen!',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/feigenbaum.jpg',
  ),
];
