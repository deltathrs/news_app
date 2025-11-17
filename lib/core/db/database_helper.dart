import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static const String DB_NAME = 'news_app.db'; // nama database
  static const String TABLE_NEWS = 'news'; // nama tabel

  static Future<Database> database() async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      DB_NAME,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NEWS(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT,
            description TEXT,
            url TEXT,
            publishedAt TEXT,
            content TEXT
          )
        ''');
      },
    );

    return _database!;
  }
}
