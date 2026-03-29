import 'goal_progress_entity.dart';
import 'goal_progress.dart';

class GoalProgressMock implements GoalProgress {

  static List<GoalProgressEntity> progressList = <GoalProgressEntity>[];

  @override
  Future<void> insertProgress(GoalProgressEntity progress) async {
    progressList.add(progress);
  }

  @override
  Future<List<GoalProgressEntity>> getProgressByGoalId(String gid) async {
    return progressList.where((progress) => progress.gid == gid).toList();
  }

  @override
  Future<void> deleteProgressByGoalId(String gid) async {
    progressList.removeWhere((progress) => progress.gid == gid);
  }
}