import 'package:routine_app/repository/goal_entity.dart';

class GoalRepository {

  static List<GoalEntity> goals = <GoalEntity>[
    // GoalEntity(id: 'G00001',title: '7時に起きるるるるるるるるるる',descrip: '',times: 1, frequency: 'd',term: 7,stime: DateTime(2020, 12, 20),etime: DateTime(2020, 12, 27))
    ];

  static List<GoalEntity> selectValidGoals(){
    final now = DateTime.now();
    return goals.where((goal) => goal.stime.isBefore(now) && goal.etime == null).toList();
  }

  static GoalEntity getGoalById(String id) {
    return goals.firstWhere((goal) => goal.id == id);
  }

  static void insertGoal(GoalEntity goal){
    goals.add(goal);
  }

  static void updateFinishedGoal(String id) {
    goals.firstWhere((goal) => goal.id == id).etime = DateTime.now();
  }
}