import 'goal_progress_entity.dart';
import 'goal_progress.dart';
import 'db_helper.dart';

class GoalProgressRepository implements GoalProgress {

  @override
  Future<void> insertProgress(GoalProgressEntity enitty) async {
    final db = await DBHelper.instance.database;
    await db.insert('goal_progress', enitty.toMap());
  }

  @override
  Future<List<GoalProgressEntity>> getProgressByGoalId(String gid) async {
    final db = await DBHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'goal_progress',
      where: 'gid = ?',
      whereArgs: [gid],
    );
    return maps.map((map) => GoalProgressEntity.fromMap(map)).toList();
  }
}
