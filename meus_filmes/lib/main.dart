import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MeusFilmesApp());
}

class MeusFilmesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
