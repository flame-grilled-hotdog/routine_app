import 'package:routine_app/repository/goal_entity.dart';
import 'package:routine_app/repository/goal_mt.dart';
import 'package:routine_app/repository/goal_mt_mock.dart';
import 'package:routine_app/repository/goal_repository.dart';
import 'package:routine_app/repository/goal_progress_entity.dart';
import 'package:routine_app/repository/goal_progress_repository.dart';
import 'package:routine_app/repository/goal_progress_mock.dart';
import 'package:routine_app/repository/goal_progress.dart';
import '../screen/home_screen.dart';

class HomeApp{
  int env;
  List<GoalProgressEntity> lst=[];
  HomeApp({required this.env});

  late final GoalProgress repo = env == 0 ? GoalProgressRepository() : GoalProgressMock();
  late final GoalMt goalRepo = env == 0 ? GoalRepository() : GoalMtMock();


  Future<Home> getProgressByGoalId(String gid) async{
    List<GoalProgressEntity> lst = await repo.getProgressByGoalId(gid);
    Home a = Home(gid: gid, cnt: lst.length);
    return a;
  }


  void addGoal(String title, String descrip) async{
    List<GoalEntity> gmLst = await goalRepo.getAll();
    String num = 'G${(gmLst.length + 1).toString().padLeft(5,'0')}';
    GoalEntity goal = GoalEntity(gid: num, title: title, descrip: descrip, times: 1, frequency: '', term: 7, sdate: DateTime.now(), edate: null);
    goalRepo.insertGoal(goal);
  }

 void updateArcheive(String id) async {

    /* 達成状況追加。 */
    repo.insertProgress(GoalProgressEntity(gid: id, udate: DateTime.now()));

    GoalEntity goal = await goalRepo.getGoalById(id);
    List<GoalProgressEntity> prglst = await repo.getProgressByGoalId(id);
    int a = prglst.length;
    int endTimes = (goal.term/goal.times).round();
    if((endTimes - a) == 1) {
      /* 目標クローズ */
      goalRepo.updateFinishedGoal(id);
    }
  }

  Future<List<GoalEntity>> getValidGoal() async {
    List<GoalEntity> a = await goalRepo.getValidGoals();
    return await goalRepo.getValidGoals();
  } 

  Future<String> getGoalById(String id) async {
    GoalEntity gmLst = await goalRepo.getGoalById(id);
    return gmLst.title;
  }
}