import 'package:routine_app/repository/goal_mt.dart';
import 'package:routine_app/repository/goal_mt_entity.dart';
import 'package:routine_app/repository/db_helper.dart';

class GoalMtRepository implements GoalMt {

  @override
  Future<List<GoalEntity>> getAll() async{
    final db = await DBHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('goal_mt');
    return maps.map((map) =>GoalEntity.fromMap(map)).toList();
    
  }

  @override
  Future<List<GoalEntity>> getValidGoals() async{
    final db = await DBHelper.instance.database;
    final now = DateTime.now();
    final List<Map<String, dynamic>> maps = await db.query('goal_mt', where: 'sdate <= ? AND (edate IS NULL OR edate > ?)', whereArgs: [now.toIso8601String(), now.toIso8601String()]);
    return maps.map((map) =>GoalEntity.fromMap(map)).toList();

  }

  @override
  Future<GoalEntity> getGoalById(String id) async {
    final db = await DBHelper.instance.database;
    final List<Map<String, Object?>> maps = await db.query('goal_mt', where: 'gid = ?', whereArgs: [id]);
    List<GoalEntity> lst = maps.map((map)=>GoalEntity.fromMap(map)).toList();
    return lst[0];
    
  }

  @override
  Future<void> insertGoal(GoalEntity goal) async {
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

}