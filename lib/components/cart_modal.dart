import 'package:flutter/material.dart';
import '../models/cartItemModel.dart';
import '../screens/cart_details.dart';

class ViewCartButton extends StatelessWidget {
  final List<CartItem> cartItems;

  ViewCartButton({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return cartItems.isNotEmpty
        ? ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   // MaterialPageRoute(
              //     // builder: (context) => CartDetailsScreen(cartItems: cartItems),
              //   ),
              // );
            },
            child: Text('View Cart'),
          )
        : SizedBox.shrink();
  }
}
