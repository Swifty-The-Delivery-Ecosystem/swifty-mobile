class UserModel {
  late String name;
  late String email;
  late String password;
  late int phone;
  List<String> favouriteVendors = [];
  late int primaryLocation;
  OTP? otp; // Marking OTP as nullable
  bool? isVeg; // Marking isVeg as nullable

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.primaryLocation,
    this.otp,
    this.isVeg,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      if (favouriteVendors.isNotEmpty) "favouriteVendors": favouriteVendors,
      "primaryLocation": primaryLocation,
      if (otp != null) "otp": otp!.toJson(),
      if (isVeg != null) "isVeg": isVeg,
    };
  }
}

class OTP {
  int? code;
  DateTime? expiresAt;

  OTP({this.code, this.expiresAt});

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "expiresAt": expiresAt?.toIso8601String(),
    };
  }
}