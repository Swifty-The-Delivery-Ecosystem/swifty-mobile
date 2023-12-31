class User {
  String? id;
  int phone;
  int primaryLoc;
  String name;

  User({this.id, required this.phone, required this.primaryLoc, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      phone: json['phone'],
      primaryLoc: json['primary_loc'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'phone': phone,
      'primary_loc': primaryLoc,
      'name': name,
    };

    if (id != null) {
      json['_id'] = id;
    }

    return json;
  }
}
