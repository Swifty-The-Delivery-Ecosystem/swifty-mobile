// cart_screen.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:swifty_mobile/models/userModel.dart';
import 'package:swifty_mobile/providers/user_provider.dart';
import '../models/cartItemModel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../providers/cart_provider.dart'; // Add this line
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late double totalAmount;
  late var order_id;
  late UserModel curUser;
  late CartProvider cartProvider;
  late var cartItems;

  Future<void> envLoader() async {
    await dotenv.load(fileName: ".env");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    envLoader();

    curUser = context.read<User>().user;
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    cartItems = cartProvider.cartItems;
    // Calculate the total amount
    totalAmount = cartProvider.cartItems.fold<double>(
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
                        Text('₹${cartItem.menuItem.price * cartItem.quantity}'),
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
          Container(
            width: double.infinity, // Make the button span the full width
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showPaymentOptionsDialog(context);
              }, // Add your onPressed logic here
              child: Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Payment Option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Handle Cash on Delivery (COD) logic
                  Navigator.pop(context);
                  const String orderUrl =
                      "https://order-service-peach.vercel.app/api/v1/order_service/user";
                  final Map<String, dynamic> orderRequestData = {
                    "user_id": curUser.userId,
                    "items": cartItems,
                    "amount": totalAmount,
                    "vendor_id": cartItems[0].restaurantId,
                    "order_instructions": "Please Send Cutlery",
                    "payment_method": 'pending',
                    "order_id": order_id,
                    "user_location": curUser.primaryLocation,
                  };

                  try {
                    final http.Response response = await http.post(
                      Uri.parse(orderUrl),
                      headers: {
                        "Content-Type": "application/json",
                        "Authorization": "Bearer ${curUser.tokenId}",
                      },
                      body: jsonEncode(orderRequestData),
                    );

                    if (response.statusCode == 201) {
                      final Map<String, dynamic> result =
                          jsonDecode(response.body);
                      // Process the result as needed
                      print("Order placed successfully. Result: $result");
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      // Handle server error or other status codes
                      print(
                          "Failed to place order. Status code: ${response.statusCode}");
                    }
                  } catch (error) {
                    // Handle any network or request errors
                    print("Error: $error");
                  }
                  // Add your COD logic here
                },
                child: Text("COD"),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  late final int amount;
                  late final String currency;
                  Razorpay razorpay = Razorpay();

                  final String url =
                      "https://payment-gateway-mocha.vercel.app/payment";

                  final Map<String, dynamic> requestData = {
                    "amount": (totalAmount * 100).toInt(),
                  };

                  try {
                    final http.Response response = await http.post(
                      Uri.parse(url),
                      headers: {
                        "Content-Type": "application/json",
                      },
                      body: jsonEncode(requestData),
                    );

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      print(response);
                      final Map<String, dynamic> result =
                          jsonDecode(response.body);
                      print(result);
                      amount = result['amount'];
                      order_id = result['id'];
                      currency = result['currency'];
                    } else {
                      print("Server error. Are you online?");
                    }
                  } catch (error) {
                    print("Error: $error");
                  }

                  var options = {
                    'key': dotenv.env['RAZORPAY_KEY_ID'],
                    'amount': (amount * 100).toString(),
                    'currency': currency,
                    'name': 'Swifty.',
                    'description': 'Food Order',
                    'order_id': order_id,
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {
                      'contact': '7048905680',
                      'email': 'tusharbansal22303@gmail.com'
                    },
                    'external': {
                      'wallets': ['paytm', 'gpay']
                    }
                  };
                  razorpay.on(
                      Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                      handleExternalWalletSelected);
                  razorpay.open(options);
                  Navigator.pop(context);
                },
                child: Text("Pay Online"),
              ),
            ],
          ),
        );
      },
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    final data = response.data;

    final String url =
        "https://payment-gateway-mocha.vercel.app/payment/success";

    final Map<String, dynamic> load = {
      "orderCreationId": order_id,
      "razorpayPaymentId": data?['razorpay_payment_id'],
      "razorpayOrderId": data?['razorpay_order_id'],
      "razorpaySignature": data?['razorpay_signature'],
    };

    try {
      final http.Response result = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(load),
      );

      if (result.statusCode == 200) {
        print("Payment success response: ${result.body}");
      } else {
        print(
            "Failed to send payment success data. Status code: ${result.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
    final Map<String, dynamic> orderRequestData = {
      "user_id": curUser.userId,
      "items": cartItems,
      "amount": totalAmount,
      "vendor_id": cartItems[0].restaurantId,
      "order_instructions": "Please Send Cutlery",
      "payment_method": 'paid',
      "order_id": order_id,
      "user_location": curUser.primaryLocation,
    };
    print(response.data.toString());
    context.read<CartProvider>().clearCart();

    showAlertDialog(context, "Payment Successful", "");
    await Future.delayed(Duration(seconds: 1));

    const String orderUrl =
        "https://order-service-peach.vercel.app/api/v1/order_service/user";

    try {
      final http.Response response = await http.post(
        Uri.parse(orderUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${curUser.tokenId}",
        },
        body: jsonEncode(orderRequestData),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        // Process the result as needed
        print("Order placed successfully. Result: $result");
      } else {
        // Handle server error or other status codes
        print("Failed to place order. Status code: ${response.statusCode}");
      }
    } catch (error) {
      // Handle any network or request errors
      print("Error: $error");
    }

    Navigator.pop(context);
    Navigator.pop(context);
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
