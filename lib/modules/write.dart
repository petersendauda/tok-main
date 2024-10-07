import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill; // Import for flutter_quill

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  String title = ''; // Title variable
  final quill.QuillController _controller = quill.QuillController.basic(); // Quill controller

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

  void _capitalizeFirstLetter() {
    final text = _controller.document.toPlainText();
    if (text.isNotEmpty) {
      // Split the text into sentences
      final sentences = text.split(RegExp(r'(?<=[.!?]) +'));
      final capitalizedSentences = sentences.map((sentence) {
        if (sentence.isNotEmpty) {
          return sentence[0].toUpperCase() + sentence.substring(1);
        }
        return sentence;
      }).toList();
      // Join the sentences back together
      final newText = capitalizedSentences.join(' ');
      // Update the Quill editor with the new text
      _controller.replaceText(0, text.length, newText, null);
    }
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
      body: Center( // Center the container
        child: Container(
          width: 700, // Set the width of the container
          padding: EdgeInsets.all(16.0), // Add padding inside the container
          child: SingleChildScrollView(
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
                  autofocus: true, // Autofocus on the title field
                ),
                SizedBox(height: 16),
                // Quill Editor for user input
                Container(
                  height: 400, // Set a fixed height for the editor
                  child: quill.QuillEditor(
                    controller: _controller,
                    focusNode: _quillFocusNode, // Set focus node for the Quill editor
                    scrollController: ScrollController(), // For scrollable
                    // readOnly: false, // Set to true for read-only mode
                    // placeholder: 'Say Your Mind', // Hint text in the editor
                    // onChanged: (value) {
                    //   // Capitalize the first letter of each sentence
                    //   _capitalizeFirstLetter();
                    // },
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