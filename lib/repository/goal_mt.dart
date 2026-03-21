import 'goal_mt_entity.dart';

abstract class GoalMt {
  Future<List<GoalEntity>> getAll();
  Future<List<GoalEntity>> getValidGoals();
  Future<GoalEntity> getGoalById(String id);
  void insertGoal(GoalEntity goal);
  void updateFinishedGoal(String id);
}