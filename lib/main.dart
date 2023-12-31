import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:swifty_mobile/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard()
    );
  }
}

