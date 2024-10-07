import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Color(0xFFF0F4F9),
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade200,
      tertiary: Colors.grey.shade900,
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.grey.shade900,
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade700,
      tertiary: Color(0xFFF0F4F9),
));
