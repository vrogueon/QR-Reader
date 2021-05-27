import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qrreader/src/models/scan_model.dart';
export 'package:qrreader/src/models/scan_model.dart';

class DBProvider {
  
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return database;
    
    _database = await initDB();

    return _database;
  }

  initDB () async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final String path = join(documentDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
            'id INTEGER PRIMARY KEY,'
            'type TEXT,'
            'value TEXT'
          ')'
        );
      }
    );
  }

  Future<int> newScanRaw(ScanModel newScan) async {
    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans (id, type, value) "
      "VALUES (${newScan.id}, ${newScan.type}, ${newScan.value})"
    );

    return res;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;

    final res = await db.insert('Scans', newScan.toJson());

    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;

    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((scan) => ScanModel.fromJson(scan)).toList()
                              : [];
    return list;
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;

    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);

    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((scan) => ScanModel.fromJson(scan)).toList()
                              : [];
    return list;
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    
    final res = await db.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAll(int id) async {
    final db = await database;
    final res = await db.rawDelete('DELET FROM Scans');

    return res;
  }

}