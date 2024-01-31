// cart_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cartItemModel.dart';
import '../providers/cart_provider.dart'; // Add this line

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    // Calculate the total amount
    double totalAmount = cartProvider.cartItems.fold<double>(
          0.0,
          (previousValue, cartItem) =>
              previousValue + (cartItem.menuItem.price * cartItem.quantity),
        ) +
        10.0; // Adding a constant delivery charge of 10.0

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                var cartItem = cartProvider.cartItems[index];

                return Card(
                  child: ListTile(
                    title: Text(cartItem.menuItem.name),
                    subtitle: Text('₹${cartItem.menuItem.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (cartItem.quantity > 1) {
                                cartProvider.decreasequantity(cartItem);
                              } else {
                                cartProvider.removeFromCart(cartItem);
                                if (cartProvider.cartItems.isEmpty) {
                                  Navigator.pop(context);
                                }
                              }
                            });
                          },
                        ),
                        Text('${cartItem.quantity}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              cartProvider.increasequantity(cartItem);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Summary Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  // Cart items and prices
                  ...cartProvider.cartItems.map((cartItem) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cartItem.menuItem.name),
                        Text(
                            '₹${cartItem.menuItem.price * cartItem.quantity}'),
                      ],
                    );
                  }).toList(),
                  Divider(),
                  // Total amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Charge'),
                      Text('\₹10.0'),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\₹${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
