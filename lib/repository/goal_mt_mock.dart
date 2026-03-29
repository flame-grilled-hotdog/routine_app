import 'package:routine_app/repository/goal_mt_entity.dart';
import 'package:routine_app/repository/goal_mt.dart';

class GoalMtMock implements GoalMt {

  static List<GoalMtEntity> goals = <GoalMtEntity>[
    GoalMtEntity(gid: 'G00001',title: '7時に起きるるるるるるるるるる',descrip: '',times: 1, frequency: 'd',term: 7,sdate: DateTime(2020, 12, 20))
  ];

  @override
  Future<List<GoalMtEntity>> getAll() {
    return Future.value(goals);
  }

  @override
  Future<List<GoalMtEntity>> getValidGoals(){
    final now = DateTime.now();
    return Future.value(goals.where((goal) => goal.sdate.isBefore(now) && goal.edate == null).toList());
  }

  @override
  Future<GoalMtEntity> getGoalById(String id) {
    return Future.value(goals.firstWhere((goal) => goal.gid == id));
  }

  @override
  Future<void> insertGoal(GoalMtEntity goal) async {
    goals.add(goal);
  }

  @override
  Future<void> updateFinishedGoal(String id) async {
    goals.firstWhere((goal) => goal.gid == id).edate = DateTime.now();
  }
}