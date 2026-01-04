import 'package:flutter/material.dart';

/// Unity上に重ねて表示する操作UI（Flutter側）
class MainScreen extends StatelessWidget {
  final void Function(String cmd) onCommand;
  final VoidCallback onExportJson;

  const MainScreen({
    super.key,
    required this.onCommand,
    required this.onExportJson,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => onCommand('save'),
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () => onCommand('load'),
                  child: const Text('Load'),
                ),
                ElevatedButton(
                  onPressed: () => onCommand('clear'),
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () => onCommand('rotate'),
                  child: const Text('Rotate'),
                ),
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.white),
                  tooltip: 'Export JSON',
                  onPressed: onExportJson,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(child: Text('Hello Flutter')),
  //   );
  // }
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