import 'package:flutter/material.dart';
import 'time_of_day_extension.dart';
import 'page/home_page.dart';
// Import 'dart:ffi' only for non-web platforms


void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
      primarySwatch: MaterialColor(0xFFAC7EFC, {
        50: Color(0xFFAC7EFC),
        100: Color(0xFFAC7EFC),
        200: Color(0xFFAC7EFC),
        300: Color(0xFFAC7EFC),
        400: Color(0xFFAC7EFC),
        500: Color(0xFFAC7EFC),
        600: Color(0xFFAC7EFC),
        700: Color(0xFFAC7EFC),
        800: Color(0xFFAC7EFC),
        900: Color(0xFFAC7EFC),
      }),
    ),
    );
  }
}