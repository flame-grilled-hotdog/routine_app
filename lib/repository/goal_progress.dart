
import 'package:routine_app/repository/goal_progress_entity.dart';

abstract class GoalProgress{
  void insertProgress(GoalProgressEntity progress);
  Future<List<GoalProgressEntity>> getProgressByGoalId(String gid);
}