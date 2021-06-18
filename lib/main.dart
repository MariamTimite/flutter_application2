import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/city_screen.dart';
import 'package:flutter_application_2/screens/loading_screen.dart';
import 'package:flutter_application_2/screens/location_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CityScreen(),
    );
  }
}
