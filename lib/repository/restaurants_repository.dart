import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swifty_mobile/models/restaurantModel.dart';
import 'package:swifty_mobile/constants.dart';

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
      print(response);
      final data = jsonDecode(response.body);
      // List<Restaurant> restaurants = (data as List).map((e)=> Restaurant.fromJson(e)).toList();
      // print(restaurants.length);
      return data;
    }
    catch(e){
      return Future.error(e.toString());
    }
  }
}