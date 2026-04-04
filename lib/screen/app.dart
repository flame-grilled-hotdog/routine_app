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
      home: const MainScreen(),
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
  static const int num = 0;
  List<Widget> get _pages => [
    const HomeScreen(env: num),
    const GoalManageScreen(env: num)
  ];

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(children: [_pages[_currentIndex],
          if (isVisible) 
            Positioned(bottom: 10, left: 0, right: 0,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                color: textColor,
                child: SizedBox(
                  height: 100,
                  child: Stack(
                    children: [
                      const Center(child: Text('広告エリア', style: TextStyle(color: Colors.white))),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {setState(() {isVisible = false;});},
                          child: Icon(Icons.close, size: 20, color: subColor),
                        ),
                      )
                    ]
                  ),
                ),
              )
            )
        ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '目標管理'),
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