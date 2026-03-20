import 'package:flutter/material.dart';
import 'package:routine_app/app/home_app.dart';
import 'package:routine_app/repository/goal_entity.dart';

/// メイン画面
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Color bgColor = const Color.fromARGB(255, 20,20,20);
Color mainColor = const Color.fromARGB(255, 230, 199, 28);
Color subColor = const Color.fromARGB(255, 255, 170, 50);
Color accentColor = const Color.fromARGB(255, 253, 190, 0);
Color textColor = const Color.fromARGB(255, 63, 61, 61);
Color textSubColor = const Color.fromARGB(255, 0, 4, 32);


class _HomeScreenState extends State<HomeScreen> {

  List<GoalEntity> lst = HomeApp.getValidGoal;

  void renewGoalState() {
    setState(() {
      lst = HomeApp.getValidGoal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
            child: SizedBox(
              width: 400,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                if(lst.isEmpty) Text('目標がありません。\r\nやるか、今か', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color:  textColor))
                else
                  ...lst.map((e) => Text("${e.title}:${HomeApp.getProgressByGoalId(e.id).length}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(color:  textColor))),
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
    final TextStyle fontStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold,letterSpacing: 1);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        color: mainColor,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child:
            Column(children: [
              Text(num != 0 ? '目標$num' : '目標設定', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor)),

              if (num==0) ...({
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async{
                      await showModalBottomSheet(context: context, builder: (context) => const GoalSet());
                      onGoalAdd!();
                    },
                  style: ElevatedButton.styleFrom(backgroundColor: textColor, foregroundColor: mainColor),
                  child: Text('＋', style:fontStyle),
                )
              })else...({
                Center(child: Text(HomeApp.getGoalById(goalId).title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textSubColor))),
                const SizedBox(height: 2),
                    ElevatedButton(
                      onPressed: () {
                        HomeApp.updateArcheive(goalId);
                        onGoalAdd!();
                      },
                  style: ElevatedButton.styleFrom(backgroundColor: textColor, foregroundColor: subColor),
                      child: Text('達成 ！'),
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
                    HomeApp.addGoal(title, descrip);
                    Navigator.pop(context, true);}, child: const Text('追加'))
              ])
          ))
        );
      }
}


/// 下層部