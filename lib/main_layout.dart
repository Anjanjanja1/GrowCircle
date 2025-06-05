import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'offer_page.dart';
import 'search_page.dart';
import 'inbox_page.dart';
import 'profile_page.dart';
import 'help_page.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const MainLayout({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  void _onTabTapped(BuildContext context, int index) {
    Widget targetPage;

    switch (index) {
      case 0:
        targetPage = DashboardPage();
        break;
      case 1:
        targetPage = SearchPage();
        break;
      case 2:
        targetPage = OfferPage();
        break;
      case 3:
        targetPage = InboxPage();
        break;
      default:
        targetPage = DashboardPage();
    }

    // Nur navigieren, wenn Zielseite anders ist
    if (index != currentIndex) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
      );
    } else {
      // Wenn man sich schon auf ChatPage befindet trotzdem zurück zur Root-Seite navigieren
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
        (route) => false,
      );
    }
  }

  // App-Bar und Navigation-Bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Image.asset('assets/images/plants/plant_logo.png', height: 32),
            const SizedBox(width: 8),
            const Text(
              'GrowCircle',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex >= 0 ? currentIndex : 0, //Used it for the HelpPage -> it is needed to avoid an error
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onTabTapped(context, index),
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
            label: "Mitteilungen",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favoriten",
          ),
        ],
      ),
    );
  }
}
