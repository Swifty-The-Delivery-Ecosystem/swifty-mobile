import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_mobile/providers/restaurants_provider.dart';
import 'package:swifty_mobile/providers/cart_provider.dart';
import 'package:swifty_mobile/providers/user_provider.dart';
import 'package:swifty_mobile/screens/cart_details.dart';
import 'package:swifty_mobile/screens/dashboard.dart';
import 'package:swifty_mobile/screens/intro_screen.dart';
import 'package:swifty_mobile/screens/login.dart';
import 'package:swifty_mobile/screens/register.dart';
import 'package:swifty_mobile/screens/restaurant_screen.dart';
import 'package:swifty_mobile/screens/verify_screen.dart';
import '../components/location_modal.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider()
            ..getRestaurants(
                getLocationId('BH1')), // Use default location as 'BH1'
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider<User>(
          create: (_) => User(),
        )
        // Add other providers if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, userProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // initialRoute: !userProvider.user.isNull ?'/':'/login',
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (context) => IntroScreen());
              case '/dashboard':
                return MaterialPageRoute(builder: (context) => Dashboard());
              case '/login':
                return MaterialPageRoute(builder: (context) => LoginScreen());
              case '/register':
                return MaterialPageRoute(
                    builder: (context) => RegisterScreen());
              case '/verify':
                return MaterialPageRoute(builder: (context) => VerifyScreen());
              case '/cart':
                return MaterialPageRoute(builder: (context) => CartScreen());
              case '/restaurant':
                // Extract parameters from settings.arguments
                final Map<String, dynamic> arguments =
                    settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                  builder: (context) => RestaurantScreen(
                    restaurant: arguments['restaurant'],
                  ),
                );
              default:
                // Handle unknown routes
                return MaterialPageRoute(builder: (context) => Dashboard());
            }
          },
        );
      },
    );
  }
}
