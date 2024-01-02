// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_mobile/providers/restaurants_provider.dart';
import 'package:swifty_mobile/providers/cart_provider.dart';
import 'package:swifty_mobile/screens/cart_details.dart'; 
import 'package:swifty_mobile/screens/dashboard.dart';
import 'package:swifty_mobile/screens/intro_screen.dart';
import 'package:swifty_mobile/screens/login.dart';
import 'package:swifty_mobile/screens/restaurant_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider()..getRestaurants(1),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        // Add other providers if needed
      ],
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => IntroScreen());
            case '/dashboard':
              return MaterialPageRoute(builder: (context) => Dashboard());
            case '/login':
              return MaterialPageRoute(builder: (context) => LoginScreen());
            case '/cart':
              return MaterialPageRoute(builder: (context) => CartScreen());  
            case '/restaurant':
              // Extract parameters from settings.arguments
              final Map<String, dynamic> arguments =
                  settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => RestaurantScreen(
                  menuItems: arguments['menuItems'],
                  restaurant: arguments['restaurant'],
                ),
              );
            default:
              // Handle unknown routes
              return MaterialPageRoute(builder: (context) => Dashboard());
          }
        },
      ),
    );
  }
}
