import 'package:flutter/material.dart';
import 'package:routine_app/screen/app.dart';
import 'screen/city_unity_page.dart';

void main() {
  debugPrint('main() started');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CityUnityPage(),
    );
  }
}
