import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:tok/widget/appbar.dart';
import 'package:tok/widget/searchbar.dart';
import 'package:tok/widget/sidebar.dart';
import '../widget/home/posts.dart';
import '../widget/home/updates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../widget/theme/theme_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey = GlobalKey<SliderDrawerState>();
  late String title;

  @override
  void initState() {
    super.initState();
    title = "Welcome";
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Accessing ThemeProvider
    return Scaffold(
      backgroundColor: themeProvider.themeData.colorScheme.background, // Set background color
      body: Container( // Wrap the body in a Container to ensure full coverage
        color: themeProvider.themeData.colorScheme.background, // Ensure the container uses the theme background
        child: SliderDrawer(
          appBar: _buildAppBar(),
          key: _sliderDrawerKey,
          sliderOpenSize: 179,
          slider: _buildDrawer(),
          child: SingleChildScrollView( // Already added
            child: _buildMainContent(), // Ensure main content is built
          ),
        ),
      ),
    );
  }

  SliderAppBar _buildAppBar() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SliderAppBar(
      appBarColor: themeProvider.themeData.appBarTheme.backgroundColor ?? Colors.white,
      title: AppBarWidget(),
    );
  }

  Widget _buildDrawer() {
    return DrawerWidget(
      onItemClick: (String title) {
        _sliderDrawerKey.currentState!.closeSlider();
        setState(() {
          this.title = title;
        });
      },
    );
  }

  Widget _buildMainContent() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildPostsSection(),
            ),
            Container(
              width: 1,
              height: double.infinity,
              color: themeProvider.themeData.dividerColor, // Using theme data
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Expanded(
              flex: 1,
              child: _buildUpdatesSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        PostWidget(),
      ],
    );
  }

  Widget _buildUpdatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        UpdatesWidget(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: themeProvider.themeData.textTheme.titleLarge?.color, // Using theme data
      ),
    );
  }
}
