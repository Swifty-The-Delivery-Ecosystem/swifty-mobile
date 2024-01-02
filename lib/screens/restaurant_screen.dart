import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/menuItemModel.dart';

class RestaurantScreen extends StatefulWidget {
  List<MenuItem> menuItems = [];
  RestaurantScreen({required this.menuItems});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(widget.menuItems.toString()),);
  }
}
