import 'package:flutter/material.dart';
import 'package:swifty_mobile/components/draggable_card.dart';

class CategoryCarousel extends StatefulWidget {
  @override
  _CategoryCarouselState createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  final List<Map<String, dynamic>> dummyData = [
    {
      'category': 'Category 1',
      'image': 'assets/images/category1.png',
    },
    {
      'category': 'Category 2',
      'image': 'assets/images/category1.png',
    },
    {
      'category': 'Category 3',
      'image': 'assets/images/category1.png',
    },
    {
      'category': 'Category 3',
      'image': 'assets/images/category1.png',
    },
    {
      'category': 'Category 3',
      'image': 'assets/images/category1.png',
    },
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: DraggableCard(
              category: dummyData[index]['category'],
              image: dummyData[index]['image'],
            ),
          );
        },
      ),
    );
  }
}
