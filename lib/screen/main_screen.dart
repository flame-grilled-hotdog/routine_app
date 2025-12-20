import 'package:flutter/material.dart';

/// メイン画面
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 207, 0),
      body: Center(child: 
        Column(
        children: [
          Container(
            width: 600,
            height: 120,
            child: const Panel(
                      title: '目標１',
                      child: Column(
                        children: const [
                          Text('７時に起きる'),
                          Text('毎日続けるとポイントゲット！'),
                        ],
                      ),
                    ),
          ),
          Expanded(
            child: Container(
              width: 400,
              color: const Color.fromARGB(255, 92, 93, 100),
              child: const Center(child: Text('下層（リワード）')),
            ),
          ),
          Container(
              width: 600,
              height: 100,
              color: const Color.fromARGB(255, 214, 215, 219),
              child: const Center(child: Text('下層（広告）')),
            )
        ],
      )
    )
    );
  }
}

/// 上層部
class Panel extends StatelessWidget {
  final String title;
  final Widget child;

  const Panel({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 202, 205, 228),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Center(child: child)
          ],
        ),
      ),
    );
  }
}

/// 下層部