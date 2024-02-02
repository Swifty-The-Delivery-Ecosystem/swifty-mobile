import 'package:flutter/material.dart';
import 'package:swifty_mobile/screens/restaurant_screen.dart';
import 'popular_now_card.dart';
import 'package:swifty_mobile/models/restaurantModel.dart';

class PopularNowCarousel extends StatelessWidget {
  final List<Restaurant> restaurants;

  PopularNowCarousel({required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          Restaurant restaurant = restaurants[index];
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/restaurant',
                  arguments: {
                    // 'menuItems': restaurant.items,
                    'menuItems': [],
                    'restaurant': restaurant,
                  },
                );
              },
              child: PopularNowCard(
                title: restaurant.restaurantName,
                rating: restaurant.ratings!,
                image: restaurant.images![0],
                onPressed: () {
                  // Handle card press
                },
                onLike: (value) {
                  // Handle like button press
                },
                // favorite: restaurant.isFavorite,
              ),
            ),
          );
        },
      ),
    );
  }
}
