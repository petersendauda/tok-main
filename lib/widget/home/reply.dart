import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // Commented out provider import
// import '../../widget/theme/theme_provider.dart'; // Commented out theme provider import

class ReplyWidget extends StatefulWidget {
  final Function(String) onReply;

  const ReplyWidget({Key? key, required this.onReply}) : super(key: key);

  @override
  _ReplyWidgetState createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add comment',
                hintStyle: TextStyle(color: Colors.grey), // Updated to a static color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.grey), // Updated to a static color
                ),
                filled: true,
                fillColor: Colors.white, // Updated to a static color
              ),
              style: TextStyle(color: Colors.black), // Updated to a static color
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.grey), // Updated to a static color
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onReply(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
