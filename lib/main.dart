import 'package:flutter/material.dart';
import 'package:swifty_mobile/screens/intro_screen.dart'; // Import the intro_screen.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(), // Use IntroScreen as the home
    );
  }
}
