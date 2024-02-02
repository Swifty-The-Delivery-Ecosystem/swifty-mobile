import 'menuItemModel.dart';

class CartItem {
  MenuItem menuItem;
  int quantity;
  String restaurantName;
  String restaurantId;

  CartItem(
      {required this.menuItem,
      required this.quantity,
      required this.restaurantId,
      required this.restaurantName});
}
