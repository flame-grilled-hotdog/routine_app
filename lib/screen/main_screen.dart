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

  @override
  Widget build(BuildContext context) {
    // MainScreenApp model=context.read<MainScreenApp>();
    List<GoalEntity> lst = MainScreenApp.getValidGoal;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 207, 0),
      body: Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 600,
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i=0; i<lst.length; i++) ...({
                  Panel(num: i+1, child: Text(lst[i].title)),
                }),
                  Panel(num: 0, child: const Text('')),
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
  final Widget child;

  const Panel({super.key, required this.num, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 202, 205, 228),
      // elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 200),
        child:
          Column(children: [
            Text(num!=0?'目標$num':'目標設定', style: Theme.of(context).textTheme.titleMedium),

            if (num==0) ...({
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {showModalBottomSheet(context: context, builder: (context) => const GoalSet());},
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 204, 0)),
                child: const Text('＋'),
              )
            })else...({
              Center(child: child),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 2, 168, 24),foregroundColor: Colors.white),
                  child: const Text('達成！'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 0, 43),foregroundColor: Colors.white),
                  child: const Text('未達成'),
                )
              ])
            })
        ])
      )
    );
  }
}

class GoalSet extends StatefulWidget {
  const GoalSet({super.key});

  @override
  State<GoalSet> createState() => _GoalSetState();
}

class _GoalSetState extends State<GoalSet> {


  @override
  Widget build(BuildContext context) {
        String title = '';
        String descrip = '';
        String frequency = '';
        String times = '';
        String term = '';

        return Container(
          color: Colors.white,
          child: 
            Form(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Column(children: [
                  TextFormField(decoration: const InputDecoration(labelText: '目標タイトル'), maxLines: 1, onChanged: (value) {String title = value;}),
                  TextFormField(decoration: const InputDecoration(labelText: '説明'), maxLines: 3, onChanged: (value) {String descrip = value;}),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(labelText: '実施頻度（回数/）'),
                    items: ['1','2','3','4','5','6','7','8','9'].map((String value) {return DropdownMenuItem<String>(value: value,child: Text(value));}).toList(),
                    onChanged: (value) {setState(() {times = value!;});}),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(labelText: '実施頻度（/週間）'),
                    items: ['日','週','月'].map((String value) {return DropdownMenuItem<String>(value: value,child: Text(value));}).toList(),
                    onChanged: (value) {setState(() {frequency = value!;});}),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(labelText: '期間'),
                    items: ['3日','7日（1週間）','30日（1か月間）','60日（2か月間)','365日（1年間）'].map((String value) {return DropdownMenuItem<String>(value: value,child: Text(value));}).toList(),
                    onChanged: (String? value) {setState(() {term = value!;});}),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () {
                    goalAdd(title, descrip, frequency, int.parse(times), term);
                    Navigator.pop(context);}, child: const Text('追加'))
              ])
          ))
        );
      }

  // TODO 目標追加処理が動かない
  void goalAdd(String title, String descrip, String frequency, int times, String term) {
    String num = (MainScreenApp.getValidGoal.length+1).toString().padLeft(5,'0');
    String termInt = term.replaceAll(RegExp(r'[^0-9]'),'');
    GoalEntity goal=GoalEntity(id: 'G$num', title: title, descrip: descrip, times: times, frequency: frequency, term: int.parse(termInt), stime: DateTime.now(), etime: DateTime.now().add(Duration(days: int.parse(termInt))));
    MainScreenApp.addGoal(goal);
  }
}


/// 下層部