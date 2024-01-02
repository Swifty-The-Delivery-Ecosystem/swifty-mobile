import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:swifty_mobile/screens/dashboard.dart';
import 'package:swifty_mobile/screens/intro_screen.dart';
import 'package:swifty_mobile/providers/restaurants_provider.dart';
import 'package:swifty_mobile/screens/login.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider()..getRestaurants(1),
        ),
        // Add other providers if needed
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => IntroScreen(),
          '/dashboard': (context) => Dashboard(),
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
