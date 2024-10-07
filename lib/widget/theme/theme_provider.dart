import 'package:flutter/material.dart';
import 'theme.dart';
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get themeData => _themeMode == ThemeMode.dark
      ? darkMode.copyWith(scaffoldBackgroundColor: Color(0xFF181C14))
      : lightMode.copyWith(scaffoldBackgroundColor: Colors.white);
}