import 'package:flutter/material.dart';
import 'package:swifty_mobile/repository/restaurants_repository.dart';
import 'package:swifty_mobile/models/restaurantModel.dart';

class RestaurantProvider extends ChangeNotifier{
  List<Restaurant> restaurants = [];
  bool isLoading = true;

  Future<List<Restaurant>> getRestaurants(int locationID) async{
    RestaurantRepository restaurantRepository = RestaurantRepository();
    restaurants = await restaurantRepository.getRestaurants(locationID);
    isLoading = false;
    notifyListeners();
    return restaurants;
  }
}