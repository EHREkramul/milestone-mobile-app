import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/milestone_session.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'milestone.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE sessions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            start_time INTEGER NOT NULL,
            end_time INTEGER,
            is_active INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<int> insertSession(MilestoneSession session) async {
    final db = await database;
    return await db.insert(
      'sessions',
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateSession(MilestoneSession session) async {
    final db = await database;
    await db.update(
      'sessions',
      session.toMap(),
      where: 'id = ?',
      whereArgs: [session.id],
    );
  }

  Future<MilestoneSession?> getActiveSession() async {
    final db = await database;
    final maps = await db.query(
      'sessions',
      where: 'is_active = ?',
      whereArgs: [1],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return MilestoneSession.fromMap(maps.first);
  }

  Future<List<MilestoneSession>> getAllSessions() async {
    final db = await database;
    final maps = await db.query('sessions', orderBy: 'start_time DESC');
    return maps.map((m) => MilestoneSession.fromMap(m)).toList();
  }

  Future<void> deactivateAllSessions() async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.execute(
      'UPDATE sessions SET is_active = 0, end_time = ? WHERE is_active = 1',
      [now],
    );
  }

  Future<void> clearAllSessions() async {
    final db = await database;
    await db.delete('sessions');
  }
}
