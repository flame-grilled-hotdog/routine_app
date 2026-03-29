import 'package:routine_app/repository/goal_mt_entity.dart';
import 'package:routine_app/repository/goal_mt.dart';
import 'package:routine_app/repository/goal_mt_mock.dart';
import 'package:routine_app/repository/goal_mt_repository.dart';
import 'package:routine_app/repository/goal_progress_entity.dart';
import 'package:routine_app/repository/goal_progress_repository.dart';
import 'package:routine_app/repository/goal_progress_mock.dart';
import 'package:routine_app/repository/goal_progress.dart';
import 'package:routine_app/screen/goal_manage_screen.dart';

class GoalManageApp {
  int env;
  GoalManageApp({required this.env});

  late final GoalProgress repo = env == 0 ? GoalProgressRepository() : GoalProgressMock();
  late final GoalMt goalRepo = env == 0 ? GoalMtRepository() : GoalMtMock();

  Future<List<GoalManage>> getAllGoals() async {
    List<GoalMtEntity> a = await goalRepo.getAll();
    print('全件数：　${a.length}');
    List<GoalManage> res = [];
    for (GoalMtEntity goal in a) {
      List<GoalProgressEntity> lst = await repo.getProgressByGoalId(goal.gid);
      print('達成状況：　${goal.gid}　：　${lst.length}');
      GoalManage gm = GoalManage(entity: goal, cnt: lst.length);
      res.add(gm);
    }

    return res;
  }

  Future<void> deleteGoal(String id) async {
    await repo.deleteProgressByGoalId(id);
    await goalRepo.deleteGoal(id);
    print('削除目標：　$id');
  }
}