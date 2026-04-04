
import 'package:routine_app/repository/goal_progress_entity.dart';

abstract class GoalProgress{
  Future<List<GoalProgressEntity>> getProgressByGoalId(String gid);
  Future<void> insertProgress(GoalProgressEntity progress);
  Future<void> deleteProgressByGoalId(String gid);
}