import "dart:convert";
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_mobile/models/userModel.dart';

class User extends ChangeNotifier {
  late UserModel user;
  final String baseUrl = 'https://auth-six-pi.vercel.app/api/v1/auth/users';
  Future<int> register(String email, String name, String password, int phone,
      int primary_location) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
          'phone': phone,
          'primary_location': primary_location
        }),
      );

      if (response.statusCode == 200) {
        print('User registered successfully');
        user = UserModel(
            name: name,
            email: email,
            password: password,
            phone: phone,
            primaryLocation: 1);
      } else {
        print('Error registering user: ${response.statusCode}');
        // Handle errors as needed
      }
      return response.statusCode;
    } catch (error) {
      print('Error registering user: $error');
      // Handle errors as needed
    }
    return 404;
  }

  Future<int> verifyOtp(String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'in_otp': otp,
          'email': user.email,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final token = responseData['data']['token'];
        final userId = responseData['data']['userId'];

        print('OTP verified successfully');
        print('Token: $token');
        print('UserID: $userId');
        // Handle success as needed
      } else {
        print('Error verifying OTP: ${response.statusCode}');
        // Handle errors as needed
      }
      return response.statusCode;
    } catch (error) {
      print('Error verifying OTP: $error');
      // Handle errors as needed
      // TODO:  Add validation
      return 404;
    }
  }

  Future<int> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final token = responseData['data']['token'];
        final userId = responseData['data']['userId'];

        print('Login successful');
        print('Token: $token');
        print('UserID: $userId');
        // Handle success as needed
      } else {
        print('Error logging in: ${response.statusCode}');
        // Handle errors as needed
      }
      return response.statusCode;
    } catch (error) {
      print('Error logging in: $error');
      // Handle errors as needed
      return 404;
    }
  }

  Future<void> fetchCurrentUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fetch-current-user'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final currentUser = responseData['data']['user'];

        print('Current user: $currentUser');
        // Handle success as needed
      } else {
        print('Error fetching current user: ${response.statusCode}');
        // Handle errors as needed
      }
    } catch (error) {
      print('Error fetching current user: $error');
      // Handle errors as needed
    }
  }

  Future<void> handleAdmin(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/handle-admin'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final currentUser = responseData['data']['user'];

        print('Admin access granted for: $currentUser');
        // Handle success as needed
      } else {
        print('Error handling admin: ${response.statusCode}');
        // Handle errors as needed
      }
    } catch (error) {
      print('Error handling admin: $error');
      // Handle errors as needed
    }
  }
}
