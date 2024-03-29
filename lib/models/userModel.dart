class UserModel {
  late String? name;
  late String email;
  late String password;
  late String? tokenId;
  late int? phone;
  List<String> favouriteVendors = [];
  late int? primaryLocation;
  OTP? otp; // Marking OTP as nullable
  bool? isVeg;
  String? userId; // Marking isVeg as nullable

  UserModel(
      {this.name,
      required this.email,
      required this.password,
      this.tokenId,
      this.phone,
      this.primaryLocation,
      this.otp,
      this.isVeg,
      this.userId});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      if (favouriteVendors.isNotEmpty) "favouriteVendors": favouriteVendors,
      "primaryLocation": primaryLocation,
      if (tokenId != null) "tokenId": tokenId,
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
