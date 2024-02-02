class MenuItem {
  String name;
  String item_id;
  String image_url;
  bool is_veg;
  double price;
  String description;
  int quantity;
  String vendor_id;
  double? rating;
  int? number_of_ratings;
  List<String>? tags;
  String? category;
  bool is_available;
  String? nutritional_values;
  bool? is_healthy;
  bool? on_offer;
  double? offer_price;

  MenuItem({
    required this.name,
    required this.item_id,
    required this.image_url,
    required this.is_veg,
    required this.price,
    required this.description,
    required this.quantity,
    required this.vendor_id,
    this.rating,
    this.number_of_ratings,
    this.tags,
    this.category,
    this.is_available = true,
    this.nutritional_values,
    this.is_healthy,
    this.on_offer,
    this.offer_price,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      item_id: json['item_id'],
      image_url: json['image_url'],
      is_veg: json['is_veg'],
      price: json['price'].toDouble(),
      description: json['description'],
      quantity: json['quantity'],
      vendor_id: json['vendor_id'],
      rating: json['rating']?.toDouble(),
      number_of_ratings: json['number_of_ratings'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      category: json['category'],
      is_available: json['is_available'] ?? true,
      nutritional_values: json['nutritional_values'],
      is_healthy: json['is_healthy'],
      on_offer: json['on_offer'],
      offer_price: json['offer_price']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'item_id': item_id,
      'is_veg': is_veg,
      'price': price,
      'description': description,
      'quantity': quantity,
      'vendor_id': vendor_id,
      'rating': rating,
      'number_of_ratings': number_of_ratings,
      'tags': tags,
      'category': category,
      'is_available': is_available,
      'nutritional_values': nutritional_values,
      'is_healthy': is_healthy,
      'on_offer': on_offer,
      'offer_price': offer_price,
    };
  }
}
