import 'package:flutter/material.dart';
import 'package:routine_app/screen/design.dart';
import 'package:routine_app/repository/goal_mt_entity.dart';


class GoalManageScreen extends StatefulWidget {
  const GoalManageScreen({super.key});
  @override
  State<GoalManageScreen> createState() => _GoalManageScreenState();
}

class _GoalManageScreenState extends State<GoalManageScreen> {

  List<GoalManage> goalManageList = [];

  void renewGoalState() async {
    //TODO DBから目標のリストを取ってきて、setStateする。
    goalManageList = [
      GoalManage(entity: GoalMtEntity(gid: 'G00001', title: '筋トレ', descrip: 'xxxxxxxxxxxxxxxxxxxxx。', times: 1, frequency: '', term: 7, sdate: DateTime.now())),
      GoalManage(entity: GoalMtEntity(gid: 'G00002', title: '国語10単語暗記', descrip: 'yyyyyyyyyyyyyyyyyyyyyyyyyy。', times: 1, frequency: '', term: 7, sdate: DateTime(2026, 3, 20), edate: DateTime(2026, 3, 29)),cnt: 7),
      GoalManage(entity: GoalMtEntity(gid: 'G00003', title: '寝る時間確保', descrip: 'xxxxxxxxxxxxxxxxxxxxx。', times: 1, frequency: '', term: 7, sdate: DateTime.now()),cnt: 3),
     ];

  }

  void deleteGoal(String gid) async {
    //TODO DBから目標を削除して、renewGoalStateする。
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
        children:[Icon(Icons.access_time, size: 16, color: Colors.blue), Text('開始日時：${sdate.toString().split(' ')[0]}', style: TextStyle(fontSize: 20, color: textColor))]
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[Icon(Icons.access_time, size: 16, color: Colors.blue), Text('終了予定日時：${pdate.toString().split(' ')[0]}', style: TextStyle(fontSize: 20, color: textColor))]
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[Icon(Icons.access_time, size: 16, color: Colors.blue), Text('終了日時：${edate?.toString().split(' ')[0] ?? ""}', style: TextStyle(fontSize: 20, color: textColor))]
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