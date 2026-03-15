import 'package:flutter/material.dart';
import 'package:routine_app/repository/goal_entity.dart';
import 'package:routine_app/repository/goal_repository.dart';

class MainScreenApp extends ChangeNotifier {

  static List<GoalEntity> get getValidGoal => GoalRepository.selectValidGoals();

  static void addGoal(String title, String descrip) {
    String num = (GoalRepository.goals.length+1).toString().padLeft(5,'0');
    GoalEntity goal=GoalEntity(id: 'G$num', title: title, descrip: descrip, times: 7, frequency: '', term: 7, stime: DateTime.now(), etime: DateTime.now().add(Duration(days: 7)));
    GoalRepository.insertGoal(goal);
  }

}
