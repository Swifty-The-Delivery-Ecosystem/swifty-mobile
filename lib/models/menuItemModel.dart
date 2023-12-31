class MenuItem {
  String name;
  String restaurantId;
  int type;
  double price;
  int quantity;
  String imageUrl;
  String? description;
  double? rating;

  MenuItem({
    required this.name,
    required this.restaurantId,
    required this.type,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.description,
    this.rating,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      restaurantId: json['restaurant_id'],
      type: json['type'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      imageUrl: json['image_url'],
      description: json['description'],
      rating: json['rating']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'restaurant_id': restaurantId,
      'type': type,
      'price': price,
      'quantity': quantity,
      'image_url': imageUrl,
      'description': description,
      'rating': rating,
    };
  }
}
