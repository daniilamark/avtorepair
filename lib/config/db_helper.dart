import 'dart:math';

import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE dataService(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        autoCar TEXT,
        typeService TEXT,
        name TEXT,
        countService INTEGER,
        mileage INTEGER,
        comment TEXT,
        address TEXT,
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
      String autoCar,
      String typeService,
      String name,
      int countService,
      int mileage,
      String comment,
      String address) async {
    final db = await SQLHelper.db();

    final data = {
      'autoCar': autoCar,
      'typeService': typeService,
      'name': name,
      'countService': countService,
      'mileage': mileage,
      'comment': comment,
      'address': address,
    };
    final id = await db.insert('dataService', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    return db.query('dataService', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    return db.query('dataService', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(
      int id,
      String typeService,
      String autoCar,
      String name,
      int countService,
      int mileage,
      String comment,
      String address) async {
    final db = await SQLHelper.db();

    final data = {
      'autoCar': autoCar,
      'typeService': typeService,
      'name': name,
      'countService': countService,
      'mileage': mileage,
      'comment': comment,
      'address': address,
      'createdAt': DateTime.now().toString(),
    };

    final result =
        await db.update('dataService', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('dataService', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      log(1);
    }
  }

  static Future<double> getSummaSevice() async {
    final db = await SQLHelper.db();
    var result = await db.rawQuery('SELECT countService from dataService');

    double totalSum = 0;
    for (final element in result) {
      totalSum += element['countService'] as int;
    }

    return totalSum;
  }
}
