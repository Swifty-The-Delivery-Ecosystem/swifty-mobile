import 'package:swifty_mobile/models/menuItemModel.dart';

class Menu {
  String id;
  String vendor_id;
  List<MenuItem> items;

  Menu({
    required this.id,
    required this.vendor_id,
    required this.items,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        id: json['_id'], vendor_id: json['vendor_id'], items: json['items']);
  }
}
