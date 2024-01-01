import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:swifty_mobile/screens/dashboard.dart';
import 'providers/restaurants_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_)=>RestaurantProvider()..getRestaurants(1),)],
        child: const MyApp(),)
  );
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

