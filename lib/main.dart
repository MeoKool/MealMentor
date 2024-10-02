import 'package:flutter/material.dart';
import 'package:mealmentor/screens/home_screen.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto', // Thiết lập font mặc định
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
