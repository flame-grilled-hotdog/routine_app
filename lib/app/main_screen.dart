import 'package:flutter/material.dart';
import 'package:routine_app/repository/goal_entity.dart';
import 'package:routine_app/repository/goal_repository.dart';

class MainScreenApp extends ChangeNotifier {

  static List<GoalEntity> get getValidGoal => GoalRepository.selectValidGoals();

  static void addGoal(GoalEntity goal) {
    GoalRepository.insertGoal(goal);
    // notifyListeners();
  }

}
