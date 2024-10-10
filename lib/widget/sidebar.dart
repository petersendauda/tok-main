import 'package:flutter/material.dart';
import 'package:tok/modules/screens/finya.dart';
import 'package:tok/modules/welcome.dart';

import '../modules/screens/discover.dart';
// import 'package:provider/provider.dart'; // Commented out provider import
// import '../widget/theme/theme_provider.dart'; // Commented out theme provider import

class DrawerWidget extends StatefulWidget {
  final Function(String)? onItemClick;

  const DrawerWidget({Key? key, this.onItemClick}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set a static color instead of using theme
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          ListTile(
            leading: Icon(Icons.home_outlined, color: Colors.black), // Set a static color
            title: Text('Home', style: TextStyle(color: Colors.black)), // Set a static color
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.search, color: Colors.black), // Set a static color
            title: Text('Discover', style: TextStyle(color: Colors.black)), // Set a static color
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications_none, color: Colors.black), // Set a static color
            title: Text('Notification', style: TextStyle(color: Colors.black)), // Set a static color
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications_none, color: Colors.black), // Set a static color
            title: Text('Finya', style: TextStyle(color: Colors.black)), // Set a static color
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => FinyaWidget()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.bookmark_border, color: Colors.black), // Set a static color
            title: Text('Saved', style: TextStyle(color: Colors.black)), // Set a static color
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black), // Set a static color
            title: Text('Settings', style: TextStyle(color: Colors.black)), // Set a static color
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}
