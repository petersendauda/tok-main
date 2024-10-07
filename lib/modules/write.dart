import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill; // Import for flutter_quill

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  String title = ''; // Title variable
  final quill.QuillController _controller = quill.QuillController.basic(); // Quill controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Editable title field
            GestureDetector(
              onTap: () {
                // Focus on the title field when tapped
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    title = value; // Update title as user types
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Type your title here...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  // You can customize the border and style as needed
                ),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: title.isEmpty ? Colors.grey : Colors.black,
                ),
                autofocus: false, // Do not autofocus on this field
              ),
            ),
            SizedBox(height: 16),
            // Quill Editor for user input
            // quill.QuillEditor(
            //   controller: _controller,
            //   focusNode: FocusNode(), // For autofocus
            //   scrollController: ScrollController(), // For scrollable
            //   autoFocus: true,
            //   readOnly: false, // Set to true for read-only mode
            //   placeholder: 'Type your content here...', // Placeholder text
            //   padding: EdgeInsets.zero, // Adjust padding as needed
            // ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
