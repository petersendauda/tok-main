import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/theme/theme_provider.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add comment',
                hintStyle: TextStyle(color: themeProvider.themeData.colorScheme.tertiary.withOpacity(0.6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: themeProvider.themeData.colorScheme.tertiary),
                ),
                filled: true,
                fillColor: themeProvider.themeData.colorScheme.background,
              ),
              style: TextStyle(color: themeProvider.themeData.colorScheme.tertiary),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: themeProvider.themeData.colorScheme.tertiary),
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
