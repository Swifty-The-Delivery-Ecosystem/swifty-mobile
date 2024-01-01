import 'package:flutter/material.dart';


class PopularNowCard extends StatelessWidget {
  const PopularNowCard({
    Key? key,
    required this.title,
    required this.price,
    required this.deliveryTime,
    required this.image,
    required this.onPressed,
    required this.onLike,
    this.favorite = false,
  }) : super(key: key);

  final String title;
  final double price;
  final double deliveryTime;
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
          height: 230,
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
                  placeholder: AssetImage(image),
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '${deliveryTime.round()} mins delivery',
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
