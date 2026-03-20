import 'package:flutter/material.dart';
import 'package:routine_app/app/main_screen.dart';
import 'package:routine_app/repository/goal_entity.dart';

/// メイン画面
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<GoalEntity> lst = MainScreenApp.getValidGoal;

  void renewGoalState() {
    setState(() {
      lst = MainScreenApp.getValidGoal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 207, 0),
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              children: [
                for (int i=0; i<lst.length; i++) (Panel(num: i+1, goalId: lst[i].id, onGoalAdd: renewGoalState)),
                if (lst.length<3) Panel(num: 0, goalId: '', onGoalAdd: renewGoalState) // 画面更新 
              ]
            )
          ),
          Expanded(
            child: Container(
              width: 400,
              color: const Color.fromARGB(255, 92, 93, 100),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                if(lst.isEmpty) const Text('目標がありません', style: TextStyle(color: Colors.white, fontSize: 20))
                else
                  ...lst.map((e) => Text("${e.title}:${MainScreenApp.getProgressByGoalId(e.id).length}", style: Theme.of(context).textTheme.headlineMedium)),
              ])
            )
          ),
          Container(
              width: 600,
              height: 100,
              color: const Color.fromARGB(255, 214, 215, 219),
              child: const Center(child: Text('下層（広告）')),
            )
        ],
      )
    ));
  }
}

/// 上層部
class Panel extends StatelessWidget {
  final int num;
  final String goalId;
  final VoidCallback? onGoalAdd;

  const Panel({super.key, required this.num, required this.goalId, this.onGoalAdd});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        color: const Color.fromARGB(255, 202, 205, 228),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child:
            Column(children: [
              Text(num != 0 ? '目標$num' : '目標設定', style: Theme.of(context).textTheme.titleMedium),

              if (num==0) ...({
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async{
                      await showModalBottomSheet(context: context, builder: (context) => const GoalSet());
                      onGoalAdd!();
                    },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 204, 0)),
                  child: const Text('＋'),
                )
              })else...({
                Center(child: Text(MainScreenApp.getGoalById(goalId).title, style: Theme.of(context).textTheme.titleMedium)),
                const SizedBox(height: 2),
                    ElevatedButton(
                      onPressed: () {
                        MainScreenApp.updateArcheive(goalId);
                        onGoalAdd!();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 241, 157, 1),foregroundColor: Colors.white),
                      child: const Text('達成 ！'),
                    )
              })
          ])
      ))
    );
  }
}

class GoalSet extends StatefulWidget {
  const GoalSet({super.key});

  @override
  State<GoalSet> createState() => _GoalSetState();
}

class _GoalSetState extends State<GoalSet> {

  String title = '';
  String descrip = '';

  @override
  Widget build(BuildContext context) {
        return Container(
          color: Colors.white,
          child: 
            Form(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Column(children: [
                  TextFormField(decoration: const InputDecoration(labelText: '目標タイトル'), maxLines: 1, onChanged: (value) {title = value;}),
                  TextFormField(decoration: const InputDecoration(labelText: '説明'), maxLines: 1, onChanged: (value) {descrip = value;}),
                  Text('1日1回（7回）'),
                  const SizedBox(height: 8),
                  ElevatedButton(onPressed: () {
                    MainScreenApp.addGoal(title, descrip);
                    Navigator.pop(context, true);}, child: const Text('追加'))
              ])
          ))
        );
      }
}


/// 下層部