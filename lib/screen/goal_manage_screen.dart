import 'package:flutter/material.dart';
import 'package:routine_app/screen/design.dart';
import 'package:routine_app/repository/goal_mt_entity.dart';
import 'package:routine_app/app/goal_manage_app.dart';
import 'package:intl/intl.dart';

class GoalManageScreen extends StatefulWidget {
  final int env;
  const GoalManageScreen({super.key, required this.env});
  @override
  State<GoalManageScreen> createState() => _GoalManageScreenState();
}

class _GoalManageScreenState extends State<GoalManageScreen> {
  GoalManageApp get goalManageApp => GoalManageApp(env: widget.env);

  List<GoalManage> goalManageList = [];

  void renewGoalState() async {
    List<GoalManage> a = await goalManageApp.getAllGoals();
    setState(() {
      goalManageList = a;
    });

  }

  void deleteGoal(String gid) async {
    await goalManageApp.deleteGoal(gid);
    renewGoalState();
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
        SizedBox(height: 120, child: Center(child: Text('目標管理画面', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)))),
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: 
            goalManageList.isEmpty ? Center(child: Text('目標がありません。', style: TextStyle(fontSize: 20, color: textColor))) :
            ListView.builder(
              itemCount: goalManageList.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: textColor, width: 2),
                    ),
                    child: goalListItem(
                      title: goalManageList[index].entity.title,
                      description: goalManageList[index].entity.descrip,
                      sdate: goalManageList[index].entity.sdate,
                      pdate: goalManageList[index].entity.sdate.add(Duration(days:7)),
                      edate: goalManageList[index].entity.edate,
                      cnt: goalManageList[index].cnt,
                      term: (goalManageList[index].entity.times * goalManageList[index].entity.term),
                      onDelete: () => deleteGoal(goalManageList[index].entity.gid)
                    )
                )]
              )
            )
          )
        )
       ])
     );
  }
}

Widget goalListItem({required String title, required String description, required DateTime sdate, required DateTime pdate, DateTime? edate, required int cnt, required int term, required VoidCallback onDelete}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
      SizedBox(height: 4),
      Text(description, style: TextStyle(fontSize: 14, color: textColor)),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[Icon(Icons.access_time, size: 16, color: Colors.blue), Text('開始日時：${DateFormat('yyyy/MM/dd').format(sdate)}', style: TextStyle(fontSize: 20, color: textColor))]
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[Icon(Icons.access_time, size: 16, color: Colors.blue), Text('終了予定日時：${DateFormat('yyyy/MM/dd').format(pdate)}', style: TextStyle(fontSize: 20, color: textColor))]
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[Icon(Icons.access_time, size: 16, color: Colors.blue), edate==null?Text('終了日時：----/--/--', style: TextStyle(fontSize: 20, color: textColor)):Text('終了日時：${DateFormat('yyyy/MM/dd').format(edate)}', style: TextStyle(fontSize: 20, color: textColor)) ]
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          //TODO スライドで消すUXにしたい。
          ElevatedButton(onPressed: onDelete,
            style: ElevatedButton.styleFrom(minimumSize: Size(80, 30), backgroundColor: mainColor, foregroundColor: textSubColor),
            child: Text('削除')),
          Text('$cnt/$term', style: TextStyle(fontSize: 20, color: textColor))
        ]
      ),
    ],
  );
}

class GoalManage{
  GoalMtEntity entity;
  int cnt;
  GoalManage({required this.entity, this.cnt=0});
}