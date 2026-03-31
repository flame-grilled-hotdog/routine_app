import 'package:routine_app/repository/goal_mt.dart';
import 'package:routine_app/repository/goal_mt_entity.dart';
import 'package:routine_app/repository/db_helper.dart';

class GoalMtRepository implements GoalMt {

  @override
  Future<List<GoalMtEntity>> getAll() async{
    final db = await DBHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('goal_mt');
    return maps.map((map) =>GoalMtEntity.fromMap(map)).toList();
    
  }

  @override
  Future<List<GoalMtEntity>> getValidGoals() async{
    final db = await DBHelper.instance.database;
    final now = DateTime.now();
    final List<Map<String, dynamic>> maps = await db.query('goal_mt', where: 'sdate <= ? AND (edate IS NULL OR edate > ?)', whereArgs: [now.toIso8601String(), now.toIso8601String()]);
    return maps.map((map) =>GoalMtEntity.fromMap(map)).toList();

  }

  @override
  Future<GoalMtEntity> getGoalById(String id) async {
    final db = await DBHelper.instance.database;
    final List<Map<String, Object?>> maps = await db.query('goal_mt', where: 'gid = ?', whereArgs: [id]);
    List<GoalMtEntity> lst = maps.map((map)=>GoalMtEntity.fromMap(map)).toList();
    return lst[0];
    
  }

  @override
  Future<void> insertGoal(GoalMtEntity goal) async {
    DBHelper.instance.database.then((db) {
      db.insert('goal_mt',goal.toMap());
    });
  }

  @override
  Future<void> updateFinishedGoal(String gid) async {
    DBHelper.instance.database.then((db) {
      db.update(
        'goal_mt',
        {'edate': DateTime.now().toIso8601String()},
        where: 'gid = ?',
        whereArgs: [gid],
      );
    });
  }

  @override
  Future<void> updateReOpenGoal(String id, int newTerm, int reOpen) async {
    DBHelper.instance.database.then((db) {
      db.update(
        'goal_mt',
        {'edate': null, 'term': newTerm, 'reOpen': reOpen},
        where: 'gid = ?',
        whereArgs: [id],
      );
    });
  }

  @override
  Future<void> deleteGoal(String id) async {
    DBHelper.instance.database.then((db) {
      db.delete('goal_mt', where: 'gid = ?', whereArgs: [id]);
    });
  }
}