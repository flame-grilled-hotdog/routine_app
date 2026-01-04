import 'dart:async';

import 'package:flutter/material.dart';
import 'package:routine_app/screen/main_screen.dart';

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
        // MaterialPageRoute(builder: (context) => const MainScreen())
        MaterialPageRoute(
          builder: (context) => MainScreen(
            onCommand: _onUnityCommand,
            onExportJson: _onExportJson,
          ),
        ),
      );
    });
  }

  void _onUnityCommand(String cmd) {
    debugPrint('[MainScreen] command: $cmd');
    // TODO: ここで unity_bridge などへ送る
  }

  void _onExportJson() {
    debugPrint('[MainScreen] export json');
    // TODO: export の実処理
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.psychology, size: 100, color: Color.fromARGB(255, 230, 199, 28),),
            SizedBox(height: 20),
            Text('習慣化街づくり',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ]
        )
      )
    );
  }
}