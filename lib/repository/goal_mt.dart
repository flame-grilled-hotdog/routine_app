import 'goal_mt_entity.dart';

abstract class GoalMt {
  Future<List<GoalMtEntity>> getAll();
  Future<List<GoalMtEntity>> getValidGoals();
  Future<GoalMtEntity> getGoalById(String id);
  Future<void> insertGoal(GoalMtEntity goal);
  Future<void> updateFinishedGoal(String id);
  Future<void> updateReOpenGoal(String id, int newTerm, int reOpen);
  Future<void> deleteGoal(String id);
}