// NOTE: This list is updated via OfferPage when the user adds new entries.
// Newly added plants with image file paths will use `Image.file(...)` rendering.

import 'package:latlong2/latlong.dart';

class DummyPlant {
  final String id;
  String titel;
  String kategorie;
  String lichtbedarf;
  String pflanzenstadium;
  String beschreibung;
  final LatLng standort;
  final String benutzerId;
  final String? bildPfad;
  bool? istFavorit;

  DummyPlant({
    required this.id,
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
    final String email;
  final String password;
  final List<String> favoritePlantIds;

  DummyUser({required this.id, required this.name, required this.email, required this.password, this.favoritePlantIds = const []});
}

// Dummy Benutzer
final List<DummyUser> dummyUsers = [
  DummyUser(id: 'u1', name: 'Anna', email: 'anna@example.com', password: 'password123',favoritePlantIds: [],),
  DummyUser(id: 'u2', name: 'Clara', email: 'clara@example.com', password: 'password123',favoritePlantIds: ['1', '3'], ),
  DummyUser(id: 'u3', name: 'Sophia', email: 'sophia@example.com', password: 'password123',favoritePlantIds: ['2'], ),
  DummyUser(id: 'u4', name: 'Anja', email: 'anja@example.com', password: 'password123',favoritePlantIds: ['4'], ),
  DummyUser(id: 'u5', name: 'Lukas', email: 'lukas@example.com', password: 'password123',favoritePlantIds: ['5'], ),
];

// Dummy Pflanzen rund um Graz
final List<DummyPlant> dummyPlants = [
  DummyPlant(
    id: '1',
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
    id: '2',
    titel: 'Basilikum',
    kategorie: 'Kräuter',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ableger',
    beschreibung: 'Frischer Basilikum für deine Küche',
    standort: LatLng(47.0750, 15.4500), // Lendplatz
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/basilikum.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    id: '3',
    titel: 'Aloe Vera',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Sehr pflegeleicht und heilend',
    standort: LatLng(47.0670, 15.4300), // Jakominiplatz
    benutzerId: 'u5',
    bildPfad: 'assets/images/plants/aloe_vera.jpg',
    istFavorit: true,
  ),
  DummyPlant(
    id: '4',
    titel: 'Minze',
    kategorie: 'Kräuter',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Ideal für Tee!',
    standort: LatLng(47.0735, 15.4420), // Uni Graz
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/minze.jpg',
    istFavorit: true,
  ),
  DummyPlant(
    id: '5',
    titel: 'Lavendel',
    kategorie: 'Gartenpflanze',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung: 'Duftet wunderbar!',
    standort: LatLng(47.0690, 15.4600), // Murpark
    benutzerId: 'u4',
    bildPfad: 'assets/images/plants/lavendel.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    id: '6',
    titel: 'Efeutute',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Wenig',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung: 'Perfekt fürs Regal',
    standort: LatLng(47.0780, 15.4350), // Hauptbahnhof
    benutzerId: 'u1',
    bildPfad: 'assets/images/plants/efeutute.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    id: '7',
    titel: 'Drachenbaum',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Pflegeleichter Hingucker mit langen, schmalen Blättern.',
    standort: LatLng(47.0725, 15.4480), // Schlossberg
    benutzerId: 'u5',
    bildPfad: 'assets/images/plants/drachenbaum.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    id: '8',
    titel: 'Petersilie',
    kategorie: 'Kräuter',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ableger',
    beschreibung: 'Wächst schnell nach – ideal für frische Küche.',
    standort: LatLng(47.0742, 15.4444), // Stadtpark
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/petersilie.jpg',
    istFavorit: true,
  ),
  DummyPlant(
    id: '9',
    titel: 'Thymian',
    kategorie: 'Kräuter',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Würzig duftender Küchenklassiker.',
    standort: LatLng(47.0701, 15.4499), // Murinsel
    benutzerId: 'u4',
    bildPfad: 'assets/images/plants/thymian.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    id: '10',
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
    id: '11',
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
    id: '12',
    titel: 'Oregano',
    kategorie: 'Kräuter',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung: 'Wächst kräftig – ideal für Pizza-Fans!',
    standort: LatLng(47.0697, 15.4407), // Hauptplatz
    benutzerId: 'u3',
    bildPfad: 'assets/images/plants/oregano.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    id: '13',
    titel: 'Zimmerlinde',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Große weiche Blätter, wächst schnell.',
    standort: LatLng(47.0658, 15.4455), // Jakoministraße
    benutzerId: 'u5',
    bildPfad: 'assets/images/plants/zimmerlinde.jpg',
    istFavorit: false,
  ),
  DummyPlant(
    id: '14',
    titel: 'Zitronenmelisse',
    kategorie: 'Kräuter',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Ableger',
    beschreibung: 'Beruhigend und lecker im Tee.',
    standort: LatLng(47.0711, 15.4520), // Griesplatz
    benutzerId: 'u4',
    bildPfad: 'assets/images/plants/zitronenmelisse.jpg',
    istFavorit: true,
  ),
  DummyPlant(
    id: '15',
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
    id: '16',
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
    id: '17',
    titel: 'Gummibaum',
    kategorie: 'Zimmerpflanze',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Ausgewachsen',
    beschreibung:
        'Robust und wunderbar anspruchslos - verzeiht einem wirklich alles 😄',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/gummibaum.jpg',
  ),
  DummyPlant(
    id: '18',
    titel: 'Amaryllis',
    kategorie: 'Samen',
    lichtbedarf: 'Mittel',
    pflanzenstadium: 'Samen',
    beschreibung:
        'Habe die Samen von meiner eigenen Pflanze, die rot blüht. Tausche gerne gegen Kräuter.',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/amaryllis.jpg',
  ),
  DummyPlant(
    id: '19',
    titel: 'Banane',
    kategorie: 'Sonstige',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Winterhart bis -15°C',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/banane.jpg',
  ),
  DummyPlant(
    id: '20',
    titel: 'Feigenbaum',
    kategorie: 'Sonstige',
    lichtbedarf: 'Viel',
    pflanzenstadium: 'Jungpflanze',
    beschreibung: 'Habe den Baum aus dem Kroatien-Urlaub mitgenommen!',
    standort: LatLng(47.0540, 15.2351),
    benutzerId: 'u2',
    bildPfad: 'assets/images/plants/feigenbaum.jpg',
  ),
];
