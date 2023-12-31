// profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              'Name: John Doe', // Replace with actual name
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Phone: 123-456-7890', // Replace with actual phone number
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Email: john.doe@example.com', // Replace with actual email
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
