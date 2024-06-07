import 'dart:math';

import 'package:sqflite/sqflite.dart' as sql;

class DBDocLocal {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE dataDoc(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        link TEXT,
        name TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database_name.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createdData(
    String link,
    String name,
  ) async {
    final db = await DBDocLocal.db();

    final data = {
      'link': link,
      'name': name,
    };
    final id = await db.insert('dataDoc', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await DBDocLocal.db();
    return db.query('dataDoc', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await DBDocLocal.db();
    return db.query('dataDoc', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(
    int id,
    String link,
    String name,
  ) async {
    final db = await DBDocLocal.db();

    final data = {
      'link': link,
      'name': name,
      'createdAt': DateTime.now().toString(),
    };

    final result =
        await db.update('dataDoc', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await DBDocLocal.db();
    try {
      await db.delete('dataDoc', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      log(1);
    }
  }
}
