import 'package:flutter/material.dart';
import 'package:routine_app/app/home_app.dart';
import 'package:routine_app/repository/goal_entity.dart';
import 'package:routine_app/screen/design.dart';

/// メイン画面

HomeApp homeApp = HomeApp(env: 0);
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Home{
  String gid;
  String? title;
  int cnt;
  Home({required this.gid, required this.cnt, this.title});  
}

class _HomeScreenState extends State<HomeScreen> {

  List<GoalEntity> gmLst=[];
  List<Home> homeLst = [];

  void renewGoalState() async {
    final List<GoalEntity> data = await homeApp.getValidGoal();

    List<Home> a = [];
    for (GoalEntity d in data){
      Home b = await homeApp.getProgressByGoalId(d.gid);
      b.title=d.title;
      a.add(b);
    }

    setState(() {
      gmLst = data;
      homeLst = a;
    });
  }

  @override
  void initState() {
    super.initState();
    renewGoalState();
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
            children: [
              for (int i=0; i<gmLst.length; i++) (Panel(num: i+1, goalId: gmLst[i].gid, title: gmLst[i].title, onGoalAdd: renewGoalState)),
              if (gmLst.length < 3) Panel(num: 0, onGoalAdd: renewGoalState) // 画面更新 
            ]
          )
        ),
        Expanded(
          child: SizedBox(
            width: 400,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if(homeLst.isEmpty) Text('目標がありません。\r\nやるか、今か', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color:  textColor))
              else
                ...homeLst.map((e) => 
                  Text("${e.title}:${e.cnt}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(color:  textColor))
              )
            ])
          )
        )
      ]
    ));
  }
}

/// 上層部
class Panel extends StatelessWidget {
  final int num;
  final String? goalId;
  final String? title;
  final VoidCallback onGoalAdd;

  const Panel({super.key, required this.num, this.goalId, this.title, required this.onGoalAdd});

  @override
  Widget build(BuildContext context) {
    final TextStyle fontStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold,letterSpacing: 1);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        color: mainColor,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child:
            Column(children: [
              Text(num != 0 ? '目標$num' : '目標設定', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor)),

              if (num==0) ...({
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async{
                      await showModalBottomSheet(context: context, builder: (context) => const GoalSet());
                      onGoalAdd();
                    },
                  style: ElevatedButton.styleFrom(shape: CircleBorder(), backgroundColor: textColor, foregroundColor: mainColor),
                  child: Text('＋', style:fontStyle),
                )
              })else...({
                Center(child: Text(title!, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textSubColor))),
                const SizedBox(height: 1),
                ElevatedButton(
                  onPressed: () {
                    homeApp.updateArcheive(goalId!);
                    onGoalAdd();
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(80, 30), backgroundColor: textColor, foregroundColor: subColor),
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
                    homeApp.addGoal(title, descrip);
                    Navigator.pop(context, true);}, child: const Text('追加'))
              ])
          ))
        );
      }
}


/// 下層部