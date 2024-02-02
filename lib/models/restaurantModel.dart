import 'menuItemModel.dart';

class Restaurant {
  String? id;
  String ownerName;
  String restaurantName;
  String email;
  String phone;
  double? ratings;
  List<int> supported_location;
  int location;
  int? number_of_ratings;
  List<String>? tags;
  List<String>? images;
  String? status;
  List<String>? delivery_partners;
  bool is_active; // Corrected the capitalization of 'Bool' to 'bool'
  String? description;

  // Corrected the constructor parameter names to match the usage in the 'fromJson' factory method
  Restaurant({
    this.id,
    required this.ownerName,
    required this.restaurantName,
    required this.email,
    this.description,
    this.ratings,
    required this.supported_location,
    required this.phone,
    required this.is_active,
    this.number_of_ratings,
    this.tags,
    this.status,
    this.images,
    this.delivery_partners,
    required this.location,
  });

  // Updated the 'fromJson' factory method to use correct parameter names and types
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'],
      ownerName: json['ownerName'],
      restaurantName: json['restaurantName'],
      email: json['email'],
      phone: json['phone'],
      is_active: json['isActive'],
      ratings: json['ratings'],
      supported_location: List<int>.from(json['supported_location']),
      location: json['location'],
      number_of_ratings: json['number_of_ratings'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      status: json['status'] != null ? json['status'] : null,
      delivery_partners: json['delivery_partners'] != null
          ? List<String>.from(json['delivery_partners'])
          : null,
      description: json['description'],
    );
  }

  // Updated the 'toJson' method to use correct parameter names
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'owner': ownerName,
      'name': restaurantName,
      'email': email,
      'phone': phone,
      'is_active': is_active,
      'ratings': ratings,
      'supported_location': supported_location,
      'location': location,
      'number_of_ratings': number_of_ratings,
      'tags': tags,
      'images': images,
      'status': status,
      'delivery_partners': delivery_partners,
      'description': description,
    };
  }
}
