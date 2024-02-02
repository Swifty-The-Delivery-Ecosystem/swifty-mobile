import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swifty_mobile/models/restaurantModel.dart';

class RestaurantRepository {
 Future<List<Restaurant>> getRestaurants(int locationID) async {
    final client = http.Client();

    try {
      final url = Uri.parse(
          'https://inventory-service-git-main-swiftyeco.vercel.app/api/v1/inventory/customer/vendors');
      final Map<String, dynamic> requestData = {
        'location': "1",
      };

      final response = await client.get(
        url.replace(queryParameters: requestData),
        headers: {'Content-Type': 'application/json'},
      );

      final List<dynamic> data = jsonDecode(response.body);
      print("iufgo uehtoiuehruhuier  geue uergh");
      print(data);

      List<Restaurant> restaurants =
          data.map((item) => Restaurant.fromJson(item)).toList();

      return restaurants;
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    } finally {
      client
          .close(); // Close the HTTP client in the finally block to avoid resource leaks
    }
  }

}
