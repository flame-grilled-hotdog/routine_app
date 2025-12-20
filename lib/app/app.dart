import 'package:flutter/material.dart';

/// アプリ本体
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '習慣化街づくり',
      locale: Locale('ja'),
      supportedLocales: const [Locale('en'), Locale('ja'), Locale('zh', 'TW')],
    );
  }
}