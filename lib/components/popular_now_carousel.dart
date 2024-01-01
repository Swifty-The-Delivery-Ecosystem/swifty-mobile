import 'package:flutter/material.dart';
import 'popular_now_card.dart';

class PopularNowCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> dummyData = [
    {
      'title': 'Food Item 1',
      'price': 15.99,
      'deliveryTime': 30.0,
      'image': 'assets/images/category1.png',
    },
    {
      'title': 'Food Item 2',
      'price': 12.99,
      'deliveryTime': 25.0,
      'image': 'assets/images/category1.png',
    },
    {
      'title': 'Food Item 3',
      'price': 18.99,
      'deliveryTime': 35.0,
      'image': 'assets/images/category1.png',
    },
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: PopularNowCard(
              title: dummyData[index]['title'],
              price: dummyData[index]['price'],
              deliveryTime: dummyData[index]['deliveryTime'],
              image: dummyData[index]['image'],
              onPressed: () {},
              onLike: (value) {},
              favorite: false,
            ),
          );
        },
      ),
    );
  }
}
