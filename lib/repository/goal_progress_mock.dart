import 'goal_progress_entity.dart';
import 'goal_progress.dart';

class GoalProgressMock implements GoalProgress {

  static List<GoalProgressEntity> progressList = <GoalProgressEntity>[];

  @override
  void insertProgress(GoalProgressEntity progress) {
    progressList.add(progress);
  }

  @override
  Future<List<GoalProgressEntity>> getProgressByGoalId(String gid) async {
    return progressList.where((progress) => progress.gid == gid).toList();
  }
}