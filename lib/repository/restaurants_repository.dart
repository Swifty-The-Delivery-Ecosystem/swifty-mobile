import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swifty_mobile/models/restaurantModel.dart';

class RestaurantRepository{
  Future<List<Restaurant>> getRestaurants(int locationID) async{
    final client = http.Client();

    try{
      final url = Uri.parse('https://inventory-service-git-main-swiftyeco.vercel.app/api/customer/restaurants');
      final Map<String, dynamic> requestData = {'location': '1'};

      final response = await client.get(
        url.replace(queryParameters: requestData),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);
      List<Restaurant> restaurants = [];

      for(var item in data){
        restaurants.add(Restaurant.fromJson(item));
      }
      // print(restaurants.length);
      // print(restaurants);
      return restaurants;
    }
    catch(e){
      return Future.error(e.toString());
    }
  }
}