import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill; // Import for flutter_quill

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  String title = ''; // Title variable
  String mindText = ''; // Text for "Say Your Mind"
  final quill.QuillController _controller = quill.QuillController.basic(); // Quill controller

  // Focus nodes for managing focus
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _mindTextFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Add listener to the title focus node
    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        // If title loses focus, move to the next field
        _mindTextFocusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draft'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle publish action
            },
            child: Text('Publish', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Editable title field
            TextField(
              focusNode: _titleFocusNode,
              onChanged: (value) {
                setState(() {
                  title = value; // Update title as user types
                });
              },
              onSubmitted: (value) {
                // Move focus to the next field when Enter is pressed
                _mindTextFocusNode.requestFocus();
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
              autofocus: true, // Autofocus on the title field
            ),
            SizedBox(height: 16),
            // Text field for "Say Your Mind"
            TextField(
              focusNode: _mindTextFocusNode,
              onChanged: (value) {
                setState(() {
                  mindText = value; // Update mind text as user types
                });
              },
              onSubmitted: (value) {
                // Add a new line in the Quill editor when Enter is pressed
                // _controller.insertText(_controller.selection.baseOffset, '\n');
              },
              decoration: InputDecoration(
                hintText: 'Say Your Mind',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 24,
                color: mindText.isEmpty ? Colors.grey : Colors.black,
              ),
            ),
            SizedBox(height: 16),
            // Quill Editor for user input
            Container(
              height: 400, // Set a fixed height for the editor
              child: quill.QuillEditor(
                controller: _controller,
                focusNode: FocusNode(), // For autofocus
                scrollController: ScrollController(), // For scrollable
                // readOnly: false, // Set to true for read-only mode
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}