import 'package:flutter/material.dart';

class PopularNowCard extends StatelessWidget {
  const PopularNowCard({
    Key? key,
    required this.title,
    required this.rating,
    required this.image,
    required this.onPressed,
    required this.onLike,
    this.favorite = false,
  }) : super(key: key);

  final String title;
  final double rating;
  final String image;
  final VoidCallback onPressed;
  final Function(bool value) onLike;
  final bool favorite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 155,
          height: 180,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [lightBoxShadow],
          ),
          child: Column(
            children: [
              Container(
                height: 120,
                child: FadeInImage(
                  placeholder: NetworkImage(image),
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 4, // Adjusted the vertical padding
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2), // Adjusted the SizedBox height
                    Text(
                      '★ ${rating}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () => onLike(!favorite),
            icon: favorite
                ? const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                  ),
          ),
        ),
      ],
    );
  }
}

var lightBoxShadow = BoxShadow(
  blurRadius: 5,
  spreadRadius: 1,
  color: Colors.grey.withOpacity(0.5),
  offset: const Offset(0, 1),
);
