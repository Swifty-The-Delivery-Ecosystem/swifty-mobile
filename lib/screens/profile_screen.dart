// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<User>(
          builder: (context, userProvider, _){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.grey[300], // Light gray color
                  child: Icon(
                    Icons.person,
                    size: 50.0,
                    color: Colors.grey[600], // Dark gray color
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Name: ${userProvider.user.name}', // Replace with actual name
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Phone: ${userProvider.user.phone}', // Replace with actual phone number
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Email: ${userProvider.user.email}', // Replace with actual email
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
