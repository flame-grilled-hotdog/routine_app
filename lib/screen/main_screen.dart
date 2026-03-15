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

  @override
  Widget build(BuildContext context) {
    // MainScreenApp model=context.read<MainScreenApp>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 207, 0),
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            // width: 600,
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              children: [
                for (int i=0; i<lst.length; i++) (Panel(num: i+1, goalTittle: Text(lst[i].title))),
                if (lst.length<3) Panel(num: 0, goalTittle: const Text(''), onGoalAdd: () { setState(() { lst = MainScreenApp.getValidGoal;});}) // 画面更新 
              ]
            )
          ),
          Expanded(
            child: Container(
              width: 400,
              color: const Color.fromARGB(255, 92, 93, 100),
              child: const Center(child: Text('下層（リワード）')),
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
  final Widget goalTittle;
  final VoidCallback? onGoalAdd;

  const Panel({super.key, required this.num, required this.goalTittle, this.onGoalAdd});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        color: const Color.fromARGB(255, 202, 205, 228),
        // elevation: 2,
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
                Center(child: goalTittle),
                const SizedBox(height: 2),
                    ElevatedButton(
                      onPressed: () {},
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
                    goalAdd(title, descrip);
                    Navigator.pop(context, true);}, child: const Text('追加'))
              ])
          ))
        );
      }

  // TODO 目標追加処理が動かない
  void goalAdd(String title, String descrip) {
    String num = (MainScreenApp.getValidGoal.length+1).toString().padLeft(5,'0');
    GoalEntity goal=GoalEntity(id: 'G$num', title: title, descrip: descrip, times: 7, frequency: '', term: 7, stime: DateTime.now(), etime: DateTime.now().add(Duration(days: 7)));
    print("Goal added: $goal");
    MainScreenApp.addGoal(goal);
  }
}


/// 下層部