import 'package:routine_app/repository/goal_mt_entity.dart';
import 'package:routine_app/repository/goal_mt.dart';

class GoalMtMock implements GoalMt {

  static List<GoalEntity> goals = <GoalEntity>[
    GoalEntity(gid: 'G00001',title: '7時に起きるるるるるるるるるる',descrip: '',times: 1, frequency: 'd',term: 7,sdate: DateTime(2020, 12, 20))
  ];

  @override
  Future<List<GoalEntity>> getAll() {
    return Future.value(goals);
  }

  @override
  Future<List<GoalEntity>> getValidGoals(){
    final now = DateTime.now();
    return Future.value(goals.where((goal) => goal.sdate.isBefore(now) && goal.edate == null).toList());
  }

  @override
  Future<GoalEntity> getGoalById(String id) {
    return Future.value(goals.firstWhere((goal) => goal.gid == id));
  }

  @override
  void insertGoal(GoalEntity goal){
    goals.add(goal);
  }

  @override
  void updateFinishedGoal(String id) {
    goals.firstWhere((goal) => goal.gid == id).edate = DateTime.now();
  }
}