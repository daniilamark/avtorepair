import 'dart:math';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sql;

class LocalRefueling {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE refuiling(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        typeFuel TEXT,
        count TEXT,
        summa TEXT,
        address TEXT,
        comment TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database_avorepair.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createdData(String typeFuel, String count, String summa,
      String address, String comment) async {
    final db = await LocalRefueling.db();

    final data = {
      'typeFuel': typeFuel,
      'count': count,
      'summa': summa,
      'address': address,
      'comment': comment
    };
    final id = await db.insert('refuiling', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await LocalRefueling.db();
    return db.query('refuiling', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await LocalRefueling.db();
    return db.query('refuiling', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(int id, String typeFuel, String count,
      String summa, String address, String comment) async {
    final db = await LocalRefueling.db();

    final data = {
      'typeFuel': typeFuel,
      'count': count,
      'summa': summa,
      'address': address,
      'comment': comment,
      'createdAt': DateTime.now().toString(),
    };

    final result =
        await db.update('refuiling', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await LocalRefueling.db();
    try {
      await db.delete('refuiling', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      log(1);
    }
  }

  Future<String> getCount() async {
    //database connection
    final db = await LocalRefueling.db();
    var result = await db.rawQuery('SELECT COUNT (*) from refuiling');
    //int count = Sqflite.firstIntValue(x);
    String count = result.length.toString();
    return count;
  }
}
