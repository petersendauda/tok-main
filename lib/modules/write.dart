import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill; // Import for flutter_quill
import 'package:tok/services/firestore.dart'; // Adjust the import based on your project structure
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth for getting the user ID
import 'package:tok/modules/welcome.dart'; // Adjust the import based on your project structure

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  String title = ''; // Title variable
  final quill.QuillController _controller = quill.QuillController.basic(); // Quill controller
  final FirestoreService _firestoreService2 = FirestoreService(); // Firestore service instance

  // Focus nodes for managing focus
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _quillFocusNode = FocusNode(); // Focus node for the Quill editor

  @override
  void initState() {
    super.initState();
    // Add listener to the title focus node
    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        // If title loses focus, move to the Quill editor
        _quillFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _quillFocusNode.dispose();
    super.dispose();
  }

  void _publishPost() async {
    // Get the current user's ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Get the content from the Quill editor
    final content = _controller.document.toPlainText();

    // Check if title or content is empty
    if (title.isEmpty || content.isEmpty) {
      // Show an error dialog instead of a SnackBar
      _showErrorDialog('Please enter both a title and content before posting.');
      return; // Exit the method if title or content is empty
    }

    if (userId != null) {
      print("Title: $title");
      print("Content: $content");
      print("User ID: $userId");

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
              child: Text('Tok', style: TextStyle(color: Colors.black)),
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
                // Toolbar for text formatting
                // _buildToolbar(),
                SizedBox(height: 16),
                // Editable title field
                TextField(
                  focusNode: _titleFocusNode,
                  onChanged: (value) {
                    setState(() {
                      title = value; // Update title as user types
                    });
                  },
                  onSubmitted: (value) {
                    // Move focus to the Quill editor when Enter is pressed
                    _quillFocusNode.requestFocus();
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
                SizedBox(height: 16),
                // Quill Editor for user input
                Container(
                  height: 400,
                  child: quill.QuillEditor(
                    controller: _controller,
                    focusNode: _quillFocusNode,
                    scrollController: ScrollController(),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
