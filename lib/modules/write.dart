import 'package:flutter/material.dart';
import 'package:tok/services/firestore.dart'; // Adjust the import based on your project structure
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth for getting the user ID
import 'package:tok/modules/welcome.dart'; // Adjust the import based on your project structure

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  String title = ''; // Title variable
  String content = ''; // Content variable
  bool showContentField = false; // Flag to show/hide content field
  final FirestoreService _firestoreService2 = FirestoreService(); // Firestore service instance

  // Focus nodes for managing focus
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode(); // Focus node for the content field

  @override
  void initState() {
    super.initState();
    // Add listener to the title focus node
    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus && title.isNotEmpty) {
        setState(() {
          showContentField = true; // Show content field when title loses focus
        });
        _contentFocusNode.requestFocus(); // Move focus to content field
      }
    });
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _publishPost() async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Check if title or content is empty
    if (title.isEmpty || content.isEmpty) {
      // Show an error dialog instead of a SnackBar
      _showErrorDialog('Please enter both a title and content before posting.');
      return; // Exit the method if title or content is empty
    }

    if (userId != null) {
      // Assuming content is defined elsewhere in the class or method
      // If content is not defined, ensure it is initialized or passed as a parameter
      // For demonstration, let's assume content is a placeholder string
      print("Title: $title");
      print("Content: $content");
      print("User ID: $userId");
// Placeholder content

      // Call the Firestore service to add the post
      await _firestoreService2.addPost(title, content, userId);

      // Navigate to the WelcomeScreen after posting
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    } else {
      // Handle the case where the user is not logged in
      print("User is not logged in.");
      _showErrorDialog('User is not logged in. Please log in to post.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Method to build the toolbar for the Quill editor


  Future<String?> _showLinkDialog() async {
    String? url;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController urlController = TextEditingController();
        return AlertDialog(
          title: Text('Insert Link'),
          content: TextField(
            controller: urlController,
            decoration: InputDecoration(hintText: 'Enter URL'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                url = urlController.text;
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Insert'),
            ),
          ],
        );
      },
    );
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Blogging Platform With Content Management System',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Set text color
              ),
            ),
            TextButton(
              onPressed: _publishPost, // Call the publish method
              child: Text('Tok', style: TextStyle(color: Color(0xFFE91E63))), // Updated color
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 700,
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Move the title field closer to the AppBar
                TextField(
                  focusNode: _titleFocusNode,
                  onChanged: (value) {
                    setState(() {
                      title = value; // Update title as user types
                    });
                  },
                  onSubmitted: (value) {
                    setState(() {
                      showContentField = true; // Show content field on Enter
                    });
                    _contentFocusNode.requestFocus(); // Move focus to content field
                  },
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 22),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: title.isEmpty ? Colors.grey : Colors.black,
                  ),
                  autofocus: true,
                ),
                if (showContentField) ...[
                  SizedBox(height: 16),
                  TextField(
                    focusNode: _contentFocusNode,
                    onChanged: (value) {
                      setState(() {
                        content = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Content',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null, // Allow multiple lines
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
