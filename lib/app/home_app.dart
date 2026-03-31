import 'package:routine_app/repository/goal_mt_entity.dart';
import 'package:routine_app/repository/goal_mt.dart';
import 'package:routine_app/repository/goal_mt_mock.dart';
import 'package:routine_app/repository/goal_mt_repository.dart';
import 'package:routine_app/repository/goal_progress_entity.dart';
import 'package:routine_app/repository/goal_progress_repository.dart';
import 'package:routine_app/repository/goal_progress_mock.dart';
import 'package:routine_app/repository/goal_progress.dart';
import 'package:routine_app/screen/home_screen.dart';

class HomeApp{
  int env;
  HomeApp({required this.env});

  late final GoalProgress repo = env == 0 ? GoalProgressRepository() : GoalProgressMock();
  late final GoalMt goalRepo = env == 0 ? GoalMtRepository() : GoalMtMock();


  Future<Home> getProgressByGoalId(String gid) async{
    List<GoalProgressEntity> lst = await repo.getProgressByGoalId(gid);
    print('達成状況：　$gid　：　${lst.length}');
    Home a = Home(gid: gid, cnt: lst.length);
    return a;
  }


  Future<void> addGoal(String title, String descrip) async{
    List<GoalMtEntity> gmLst = await goalRepo.getAll();
    String num = 'G${(gmLst.length + 1).toString().padLeft(5,'0')}';
    GoalMtEntity goal = GoalMtEntity(gid: num, title: title, descrip: descrip, times: 1, frequency: '', term: 7, sdate: DateTime.now(), edate: null);
    await goalRepo.insertGoal(goal);
    print('追加目標：　$num');
  }

 Future<void> updateArcheive(String id) async {

    /* 達成状況追加。 */
    repo.insertProgress(GoalProgressEntity(gid: id, udate: DateTime.now()));

    GoalMtEntity goal = await goalRepo.getGoalById(id);
    List<GoalProgressEntity> prglst = await repo.getProgressByGoalId(id);
    int a = prglst.length;
    int endTimes = (goal.term/goal.times).round();
    if((endTimes - a) == 0) {
      /* 目標クローズ */
      await goalRepo.updateFinishedGoal(id);
    }
  }

  Future<List<GoalMtEntity>> getValidGoal() async {
    List<GoalMtEntity> a = await goalRepo.getValidGoals();
    print('有効件数：　${a.length}');
    return a;
  } 

  Future<String> getGoalById(String id) async {
    GoalMtEntity gmLst = await goalRepo.getGoalById(id);
    return gmLst.title;
  }
}