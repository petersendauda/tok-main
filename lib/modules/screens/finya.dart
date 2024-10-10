import 'dart:html' as html; // Import for HTML manipulation
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
// import 'package:provider/provider.dart'; // Commented out provider import
// import '../../widget/theme/theme_provider.dart'; // Commented out theme provider import
import 'package:tok/widget/appbar.dart';
import 'package:tok/widget/sidebar.dart';

class FinyaWidget extends StatefulWidget {
  @override
  _FinyaWidgetState createState() => _FinyaWidgetState();
}

class _FinyaWidgetState extends State<FinyaWidget> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey = GlobalKey<SliderDrawerState>();
  late String title;
  final TextEditingController _controller = TextEditingController();
  List<String> messages = []; // List to hold chat messages

  @override
  void initState() {
    super.initState();
    // Add the Context AI chatbot script to the HTML document
    html.ScriptElement script = html.ScriptElement()
      ..id = '__CONTEXT_BUBBLE__'
      ..src = 'https://portal.usecontext.io/portal/portal.js'
      ..setAttribute('data-theme', 'light')
      ..setAttribute('data-type', 'attribute');

    html.document.body!.append(script);

    // Add the launcher div for the chatbot
    html.DivElement launcher = html.DivElement()
      ..setAttribute('context-launcher', 'true')
      ..setAttribute('context-bot-id', 'LxJ4wvSNO')
      ..text = 'Click to launch Context';

    html.document.body!.append(launcher);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(), // Drawer for navigation
      body: SliderDrawer(
        appBar: SliderAppBar(
          appBarColor: Colors.white, // Set a static color instead of using theme
          title: AppBarWidget(),
        ),
        key: _sliderDrawerKey,
        sliderOpenSize: 179,
        slider: DrawerWidget(
          onItemClick: (title) {
            _sliderDrawerKey.currentState!.closeSlider();
            setState(() {
              this.title = title;
            });
          },
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Hi there, What would you like to know?", // Welcome message
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Set a static color instead of using theme
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          messages.add(_controller.text); // Add message to the list
                          _controller.clear(); // Clear the input field
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}