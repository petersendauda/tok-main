import 'package:flutter/material.dart';
import 'package:tok/modules/login/signup/interest.dart';

import '../../../services/firestore.dart'; // Adjust the import as necessary

class UserInfo extends StatelessWidget {
  final String userId; // Add a field for user ID
  final String email; // Add a field for email

  const UserInfo({super.key, required this.userId, required this.email}); // Update constructor to accept userId and email

  @override
  Widget build(BuildContext context) {
    final FirestoreService _firestoreService = FirestoreService(); // Create an instance

    String fullName = '';
    String emailAddress = email; // Initialize emailAddress with the passed email

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Almost there!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Finish creating your account for the full Medium experience.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  fullName = value; // Capture full name
                },
                decoration: InputDecoration(
                  labelText: 'Your full name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: emailAddress), // Set the email field with the passed email
                decoration: InputDecoration(
                  labelText: 'Your email',
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Make the email field read-only if you don't want users to edit it
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Handle account creation
                    await _firestoreService.addUser(fullName, emailAddress, userId); // Add user to Firestore with userId
                    // Navigate to InterestWidget after successful account creation
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => InterestWidget()), // Navigate to InterestWidget
                    );
                  } catch (e) {
                    // Handle the error, e.g., show a dialog or a snackbar
                    print("Error adding user: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to create account: $e")),
                    );
                  }
                },
                child: Text('Create account'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black, minimumSize: Size(double.infinity, 50), // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
