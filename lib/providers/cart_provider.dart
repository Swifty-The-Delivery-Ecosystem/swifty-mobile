import 'package:flutter/material.dart';
import '../models/cartItemModel.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];

  void addToCart(CartItem cartItem) {
    cartItems.add(cartItem);
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    cartItems.remove(cartItem);
    notifyListeners();
  }

  void increasequantity(CartItem cartItem) {
    cartItem.quantity++;
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  void decreasequantity(CartItem cartItem) {
    if (cartItem.quantity > 0) {
      cartItem.quantity--;
    }
    notifyListeners();
  }

  void updateCartItem(CartItem cartItem) {
    int index =
        cartItems.indexWhere((item) => item.menuItem == cartItem.menuItem);
    if (index != -1) {
      cartItems[index] = cartItem;
      notifyListeners();
    }
  }
}
