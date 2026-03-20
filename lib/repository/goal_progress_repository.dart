import 'goal_progress_entity.dart';

class GoalProgressRepository {

  static List<GoalProgressEntity> progressList = <GoalProgressEntity>[];

  static void insertProgress(GoalProgressEntity progress) {
    progressList.add(progress);
  }

  static List<GoalProgressEntity> getProgressByGoalId(String goalId) {
    return progressList.where((progress) => progress.id == goalId).toList();
  }
}