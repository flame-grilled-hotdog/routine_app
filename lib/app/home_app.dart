import 'package:flutter/material.dart';
import 'package:routine_app/repository/goal_entity.dart';
import 'package:routine_app/repository/goal_repository.dart';
import 'package:routine_app/repository/goal_progress_entity.dart';
import 'package:routine_app/repository/goal_progress_repository.dart';

class HomeApp extends ChangeNotifier {

  static List<GoalEntity> get getValidGoal => GoalRepository.selectValidGoals();

  static GoalEntity getGoalById(String id) => GoalRepository.getGoalById(id);

  static List<GoalProgressEntity> getProgressByGoalId(String goalId) => GoalProgressRepository.getProgressByGoalId(goalId);

  static void addGoal(String title, String descrip) {
    String num = (GoalRepository.goals.length+1).toString().padLeft(5,'0');
    GoalEntity goal=GoalEntity(id: 'G$num', title: title, descrip: descrip, times: 7, frequency: '', term: 7, stime: DateTime.now(), etime: null);
    GoalRepository.insertGoal(goal);
  }

 static void updateArcheive(String id) {

    GoalEntity goal=GoalRepository.getGoalById(id);
    List<GoalProgressEntity> lst = GoalProgressRepository.getProgressByGoalId(id);
    if((goal.times - lst.length) == 1) {
      /* 目標クローズ */
      GoalRepository.updateFinishedGoal(id);
    }
    /* 達成状況追加。 */
    GoalProgressRepository.insertProgress(GoalProgressEntity(id: id, date: DateTime.now()));

  }
}
