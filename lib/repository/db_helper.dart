import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath(); //E:\git\sport_manager_app\.dart_tool\sqflite_common_ffi\databases\routine.db
    final path = join(dbPath, 'routine.db');
    print("DB path: $path"); // Windowsならここに出る

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // テーブル作成
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      create table tb_goal_mt(
      gid TEXT NOT NULL CHECK (length(gid) <= 7),
      title TEXT NOT NULL CHECK (length(title) <= 20),
      descrip TEXT,
      times INTEGER,
      frequency TEXT NOT NULL CHECK (length(frequency) <= 1),
      term INTEGER,
      stime DATETIME,
      etime DATETIME);
    ''');

    await db.execute('''
      create table tb_achievement_mt(
      aid TEXT NOT NULL CHECK (length(aid) <= 7),
      gid TEXT NOT NULL CHECK (length(gid) <= 7),
      utime DATETIME,
      achieve_flg INTEGER);
    ''');
  }
}
