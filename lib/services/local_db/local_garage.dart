import 'dart:math';

import 'package:sqflite/sqflite.dart' as sql;

class LocalGarage {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE garage(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        brand TEXT,
        model TEXT,
        mileage TEXT,
        yearIssue TEXT,
        typeFuel TEXT,
        volumeTank TEXT,
        number TEXT,
        vin TEXT,
        carBody TEXT,
        transmission TEXT,
        engineVolume TEXT,
        enginePower TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database_avorepair_garage.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createdData(
      String brand,
      String model,
      String mileage,
      String yearIssue,
      String typeFuel,
      String volumeTank,
      String number,
      String vin,
      String carBody,
      String transmission,
      String engineVolume,
      String enginePower) async {
    final db = await LocalGarage.db();

    final data = {
      'brand': brand,
      'model': model,
      'mileage': mileage,
      'yearIssue': yearIssue,
      'typeFuel': typeFuel,
      'volumeTank': volumeTank,
      'number': number,
      'vin': vin,
      'carBody': carBody,
      'transmission': transmission,
      'engineVolume': engineVolume,
      'enginePower': enginePower
    };
    final id = await db.insert('garage', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await LocalGarage.db();
    return db.query('garage', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await LocalGarage.db();
    return db.query('garage', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(
      int id,
      String brand,
      String model,
      String mileage,
      String yearIssue,
      String typeFuel,
      String volumeTank,
      String number,
      String vin,
      String carBody,
      String transmission,
      String engineVolume,
      String enginePower) async {
    final db = await LocalGarage.db();

    final data = {
      'brand': brand,
      'model': model,
      'mileage': mileage,
      'yearIssue': yearIssue,
      'typeFuel': typeFuel,
      'volumeTank': volumeTank,
      'number': number,
      'vin': vin,
      'carBody': carBody,
      'transmission': transmission,
      'engineVolume': engineVolume,
      'enginePower': enginePower,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('garage', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await LocalGarage.db();
    try {
      await db.delete('garage', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      log(1);
    }
  }
}
