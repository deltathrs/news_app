import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static Database? _database;

  static const String DB_NAME = 'news_app';

  static Future<Database> database() async{
    if (_database != null) return _database!;

    _database = await openDatabase(
      DB_NAME,
      version: 1,
      onCreate: (db, version) async {
        return db.execute('''
          CREATE TABLE news(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            imageLocalPath TEXT,
            publishedAt TEXT,
            content TEXT
          )
        ''');
      },
    );

    return _database!;
  }
}