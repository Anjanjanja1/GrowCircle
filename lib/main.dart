import 'package:flutter/material.dart';
import 'login_page.dart'; // wir erstellen diese Datei gleich

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pflanzen Tauschbörse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF1FDF5),
      ),
      home: LoginPage(),
    );
  }
}
