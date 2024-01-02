// restaurant_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_mobile/components/menu_card.dart';
import 'package:swifty_mobile/models/restaurantModel.dart';
import '../models/cartItemModel.dart';
import '../models/menuItemModel.dart';
import 'cart_details.dart';
import '../providers/cart_provider.dart';

class RestaurantScreen extends StatefulWidget {
  List<MenuItem> menuItems = [];
  // Remove the List<CartItem> cartItems = []; from here

  Restaurant restaurant;

  RestaurantScreen({required this.menuItems, required this.restaurant});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false); // Add this line

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: widget.menuItems.length,
        itemBuilder: (context, index) {
          var cartItem = cartProvider.cartItems.firstWhere(
            (cartItem) => cartItem.menuItem == widget.menuItems[index],
            orElse: () =>
                CartItem(menuItem: widget.menuItems[index], quantity: 0),
          );

          return MenuCard(
            item: widget.menuItems[index],
            quantityInCart: cartItem.quantity,
            onAddToCart: () {
              setState(() {
                if (cartItem.quantity > 0) {
                  cartProvider.increasequantity(cartItem); // Update cart using the provider
                } else {
                  cartProvider.addToCart(CartItem(
                      menuItem: widget.menuItems[index], quantity: 1));
                }
              });
            },
            onRemoveFromCart: () {
              setState(() {
                if (cartItem.quantity > 1) {
                  cartProvider.decreasequantity(cartItem); // Update cart using the provider
                } else {
                  cartProvider.removeFromCart(cartItem); // Remove item from cart
                }
              });
            },
            onUpdateQuantity: () {
              // Add any additional logic for updating quantity if needed
            },
          );
        },
      ),
      bottomNavigationBar: cartProvider.cartItems.isNotEmpty
          ? BottomAppBar(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                child: Text('View Cart'),
              ),
            )
          : null,
    );
  }
}
