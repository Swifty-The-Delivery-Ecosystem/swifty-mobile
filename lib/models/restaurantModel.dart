import 'menuItemModel.dart';

class Restaurant {
  String? id;
  String name;
  int location;
  List<MenuItem> items;
  String imageUrl;
  String? description;
  double? rating;

  Restaurant({
    this.id,
    required this.name,
    required this.location,
    required this.items,
    required this.imageUrl,
    this.description,
    this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'],
      name: json['name'],
      location: json['location'],
      items: (json['items'] as List<dynamic>).map((item) => MenuItem.fromJson(item)).toList(),
      imageUrl: json['image_url'],
      description: json['description'],
      rating: json['rating']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'name': name,
      'location': location,
      'items': items.map((item) => item.toJson()).toList(),
      'image_url': imageUrl,
      'description': description,
      'rating': rating,
    };

    if (id != null) {
      json['_id'] = id;
    }

    return json;
  }
}