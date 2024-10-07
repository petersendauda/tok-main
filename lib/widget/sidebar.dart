import 'package:flutter/material.dart';
import 'package:tok/modules/screens/finya.dart';
import 'package:tok/modules/welcome.dart';
import 'package:provider/provider.dart';
import '../widget/theme/theme_provider.dart';

import '../modules/screens/discover.dart';

class DrawerWidget extends StatefulWidget {
  final Function(String)? onItemClick;

  const DrawerWidget({Key? key, this.onItemClick}) : super(key: key);
  // const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      color: themeProvider.themeData.colorScheme.primary,
      padding: const EdgeInsets.only(top: 30),
      // width: 1000,
      child: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: themeProvider.themeData.colorScheme.tertiary,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: themeProvider.themeData.colorScheme.tertiary),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.search,
              color: themeProvider.themeData.colorScheme.tertiary,
            ),
            title: Text(
              'Discover',
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiscoverScreen(),
                  ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.notifications_none,
              color: themeProvider.themeData.colorScheme.tertiary,
            ),
            title: Text('Notification'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.notifications_none,
              color: themeProvider.themeData.colorScheme.tertiary,
            ),
            title: Text('Finya'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinyaWidget(),
                  ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.bookmark_border,
              color: themeProvider.themeData.colorScheme.tertiary,
            ),
            title: Text('Saved'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ));
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(
          //     Icons.home_max_outlined,
          //     color: Theme.of(context).colorScheme.tertiary,
          //   ),
          //   title: Text('Finya'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => FinyaWidget(),
          //         ));
          //   },
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
