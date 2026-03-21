import 'goal_mt_entity.dart';

abstract class GoalMt {
  Future<List<GoalEntity>> getAll();
  Future<List<GoalEntity>> getValidGoals();
  Future<GoalEntity> getGoalById(String id);
  Future<void> insertGoal(GoalEntity goal);
  Future<void> updateFinishedGoal(String id);
}