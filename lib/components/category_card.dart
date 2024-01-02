import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.image,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  final String category;
  final String image;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [lightBoxShadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          type: MaterialType.card,
          child: InkWell(
            onTap: () => onSelected(!selected),
            child: Ink(
              width: 50
              
              
              ,
              color: selected ? Colors.amber.withOpacity(0.5) : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInImage(
                    placeholder: AssetImage('assets/placeholder.jpg'),
                    image: AssetImage(image),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(category),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var lightBoxShadow = BoxShadow(
  blurRadius: 5,
  spreadRadius: 1,
  color: Colors.grey.withOpacity(0.5),
  offset: const Offset(0, 1),
);
