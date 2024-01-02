import 'package:flutter/material.dart';
import 'package:swifty_mobile/components/menu_card.dart';
import '../models/cartItemModel.dart';
import '../models/menuItemModel.dart';

class RestaurantScreen extends StatefulWidget {
  List<MenuItem> menuItems = [];
  List<CartItem> cartItems = [];

  RestaurantScreen({required this.menuItems});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.menuItems.length,
        itemBuilder: (context, index) {
          var cartItem = widget.cartItems.firstWhere(
                (cartItem) => cartItem.menuItem == widget.menuItems[index],
            orElse: () => CartItem(menuItem: widget.menuItems[index], quantity: 0),
          );

          return MenuCard(
            item: widget.menuItems[index],
            quantityInCart: cartItem.quantity,
            onAddToCart: () {
              setState(() {
                if (cartItem.quantity > 0) {
                  cartItem.quantity++;
                } else {
                  widget.cartItems.add(CartItem(menuItem: widget.menuItems[index], quantity: 1));
                }
              });
            },
            onRemoveFromCart: () {
              setState(() {
                if (cartItem.quantity > 0) {
                  cartItem.quantity--;
                }
              });
            },
            onUpdateQuantity: () {
              // Additional logic if needed when quantity is updated in the text box
            },
          );
        },
      ),
    );
  }
}
