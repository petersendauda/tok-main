import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';
import 'package:tok/widget/sidebar.dart';
import 'searchbar.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:tok/modules/login/login.dart'; // Import the Login page

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late String userName; // User's name
  late String userEmail; // User's email

  @override
  void initState() {
    super.initState();
    _fetchUserInfo(); // Fetch user info on initialization
  }

  void _fetchUserInfo() {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user != null) {
      setState(() {
        userName = user.displayName ?? "User"; // Get display name or default to "User"
        userEmail = user.email ?? "example@example.com"; // Get email or default
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color avatarColor = _getAvatarColor(userEmail); // Get color based on email

    return Container(
      color: Colors.white, // Set background color based on theme
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to the ends
          children: [
            Text(
              "Blogging Platform With Content Management System",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            // Notification icon
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black), // Notification icon
              onPressed: () {
                // Handle notification icon press
              },
            ),
            // CircleAvatar as a button
            GestureDetector(
              onTap: () {
                _showPopupMenu(context); // Show popup menu on tap
              },
              child: CircleAvatar(
                radius: 20, // Adjust the radius as needed
                backgroundColor: avatarColor, // Set background color based on user
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : 'U', // Display the first letter of the name
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvatarColor(String email) {
    // Generate a color based on the user's email or any other identifier
    int hash = email.hashCode; // Simple hash based on email
    return Color((hash & 0xFFFFFF) + 0xFF000000); // Generate a color
  }

  void _showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0), // Adjust position as needed
      items: [
        PopupMenuItem(
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: _getAvatarColor(userEmail), // Background color for the avatar
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : 'U', // Initial for the name
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName, // Name
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '@${userEmail.split('@')[0]}', // Username
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              _logout(); // Handle logout action
            },
          ),
        ),
      ],
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()), // Navigate to Login page
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    } catch (e) {
      // Handle logout errors
      print('Logout error: $e');
    }
  }
}
