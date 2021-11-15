
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
class DbHelper{

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'place.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE great_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final database = await DbHelper.database();
    database.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final database = await DbHelper.database();
    return database.query(table);
  }


}