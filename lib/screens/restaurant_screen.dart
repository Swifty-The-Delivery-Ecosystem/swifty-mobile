import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_mobile/components/menu_card.dart';
import 'package:swifty_mobile/models/menuModel.dart';
import 'package:swifty_mobile/models/restaurantModel.dart';
import 'package:swifty_mobile/providers/restaurants_provider.dart';
import '../models/cartItemModel.dart';
import '../models/menuItemModel.dart';
import '../providers/cart_provider.dart';

class RestaurantScreen extends StatefulWidget {
  List<MenuItem> menuItems = [];
  late Menu menu;
  // Remove the List<CartItem> cartItems = []; from here
  Restaurant restaurant;

  RestaurantScreen({required this.restaurant});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late List<MenuItem> filteredMenuItems;
  final TextEditingController _searchController = TextEditingController();

  Future<void> getMenuData() async {
    widget.menu = await Provider.of<RestaurantProvider>(context, listen: false)
        .getRestaurantMenu(widget.restaurant.id!);
    setState(() {
      widget.menuItems = widget.menu.items;
      filteredMenuItems = widget.menuItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getMenuData();
    filteredMenuItems = widget.menuItems;
    _searchController.addListener(() {
      filterMenuItems();
    });
  }

  void filterMenuItems() {
    setState(() {
      final String filter = _searchController.text.toLowerCase();
      filteredMenuItems = widget.menuItems.where((item) {
        return item.name.toLowerCase().contains(filter);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: true);
    print("jdbnwkefkjbf;fjkb;");
    print(widget.restaurant.restaurantName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.restaurant.restaurantName,
          style: TextStyle(color: Colors.black), // Set text color to black
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white, // Set background color to white
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredMenuItems.length,
                  itemBuilder: (context, index) {
                    var cartItem = cartProvider.cartItems.firstWhere(
                      (cartItem) =>
                          cartItem.menuItem == filteredMenuItems[index],
                      orElse: () => CartItem(
                          menuItem: filteredMenuItems[index],
                          quantity: 0,
                          restaurantId: widget.restaurant.id!,
                          restaurantName: widget.restaurant.restaurantName),
                    );

                    return MenuCard(
                      item: filteredMenuItems[
                          index], // Use filteredMenuItems here
                      quantityInCart: cartItem.quantity,
                      onAddToCart: () {
                        setState(() {
                          if (cartProvider.cartItems.isNotEmpty &&
                              cartProvider.cartItems.first.menuItem.vendor_id !=
                                  widget.restaurant.id) {
                            // Show confirmation dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Replace Cart Items?'),
                                  content: Text(
                                    'Do you want to replace items from your cart with items from ${widget.restaurant.restaurantName}?',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Cancel
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Clear the cart after a delay
                                        Future.delayed(Duration.zero, () {
                                          cartProvider.clearCart();
                                        });

                                        // Add the new item after a slight delay
                                        Future.delayed(
                                            Duration(milliseconds: 50), () {
                                          cartProvider.addToCart(
                                            CartItem(
                                                menuItem:
                                                    widget.menuItems[index],
                                                quantity: 1,
                                                restaurantId:
                                                    widget.restaurant.id!,
                                                restaurantName: widget
                                                    .restaurant.restaurantName),
                                          );
                                        });

                                        Navigator.of(context)
                                            .pop(); // Close dialog
                                      },
                                      child: Text('Replace'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (cartItem.quantity > 0) {
                            // Update cart using the provider
                            cartProvider.increasequantity(cartItem);
                          } else {
                            // Add to cart directly
                            cartProvider.addToCart(
                              CartItem(
                                  menuItem: widget.menuItems[index],
                                  quantity: 1,
                                  restaurantId: widget.restaurant.id!,
                                  restaurantName:
                                      widget.restaurant.restaurantName),
                            );
                          }
                        });
                      },
                      onRemoveFromCart: () {
                        setState(() {
                          if (cartItem.quantity > 1) {
                            cartProvider.decreasequantity(cartItem);
                          } else {
                            cartProvider.removeFromCart(cartItem);
                          }
                        });
                      },
                      onUpdateQuantity: () {
                        // Add any additional logic for updating quantity if needed
                      },
                    );
                  },
                ),
              ),
            ],
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
