import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'offer_page.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const MainLayout({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  void _onTabTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget targetPage;
    switch (index) {
      case 0:
        targetPage = DashboardPage();
        break;
      case 2:
        targetPage = OfferPage();
        break;
      default:
        targetPage = DashboardPage(); // später anpassen
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
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
            label: "Chat",
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



  // onTap: (index) {
  //         if (index == 2) {
  //           // gehe zu Angebot Seite
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => OfferPage()),
  //           );
  //         } else {
  //           setState(() {
  //             currentIndex = index;
  //             // Optional: weitere Logik für Tab-Wechsel
  //           });
  //         }
  //       },

      
      