import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart'; // Added import for Provider
import 'package:tok/widget/appbar.dart';
import 'package:tok/widget/searchbar.dart';
import 'package:tok/widget/sidebar.dart';
import '../../widget/theme/theme_provider.dart'; // Added import for ThemeProvider

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  late String title;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Get themeProvider

    return Scaffold(
      drawer: DrawerWidget(),
      body: SliderDrawer(
        appBar: SliderAppBar(
          appBarColor: themeProvider.themeData.colorScheme.background, // Use theme color
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
          children: [
            Text(
              'data1',
              style: TextStyle(
                color: themeProvider.themeData.colorScheme.onBackground, // Use theme color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
