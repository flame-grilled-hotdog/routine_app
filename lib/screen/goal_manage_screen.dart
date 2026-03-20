import 'package:flutter/material.dart';
import 'package:routine_app/screen/design.dart';

class GoalManageScreen extends StatelessWidget {
  const GoalManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 120, child: Center(child: Text('目標管理画面', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)))),
        Expanded(
          child: SizedBox(
            width: 400,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('★作成中★', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: subColor))
            ])
          )
        )
       ])
     );
  }
}