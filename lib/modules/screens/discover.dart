import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
// import 'package:provider/provider.dart'; // Commented out provider import
// import '../../widget/theme/theme_provider.dart'; // Commented out theme provider import
import 'package:tok/widget/appbar.dart';
import 'package:tok/widget/searchbar.dart';
import 'package:tok/widget/sidebar.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey = GlobalKey<SliderDrawerState>();
  late String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
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
          children: [
            Text(
              'data1',
              style: TextStyle(color: Colors.black), // Set a static color instead of using theme
            ),
          ],
        ),
      ),
    );
  }
}
