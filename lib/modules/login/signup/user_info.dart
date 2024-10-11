import 'package:flutter/material.dart';

import '../../../services/firestore.dart'; // Adjust the import as necessary

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService _firestoreService2 = FirestoreService(); // Create an instance

    String fullName = '';
    String email = '';

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
                onChanged: (value) {
                  email = value; // Capture email
                },
                decoration: InputDecoration(
                  labelText: 'Your email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Handle account creation
                    await _firestoreService2.addUser(fullName, email); // Add user to Firestore
                    // Optionally navigate to another screen or show a success message
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
