import 'dart:async';

import 'package:flutter/material.dart';
import 'package:routine_app/screen/goal_manage_screen.dart';
import 'package:routine_app/screen/home_screen.dart';
import 'package:routine_app/screen/design.dart';

/// アプリ本体
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '習慣化街づくり',
      home: const SplashScreen(),
      locale: Locale('ja'),
      // supportedLocales: const [Locale('en'), Locale('ja'), Locale('zh', 'TW')],
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const GoalManageScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '目標管理'),
        ],
      ),

    );
  }
}

/// スプラッシュスクリーン
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 2秒後にMainScreenに遷移
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.psychology, size: 100, color: mainColor),
            SizedBox(height: 20),
            Text('習慣化街づくり',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ]
        )
      )
    );
  }
}