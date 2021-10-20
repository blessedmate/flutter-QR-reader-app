import 'dart:io';
import 'package:path/path.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// DATABASE PROVIDER - Stores scans in an SQLite Database
class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  // Start the database
  Future<Database> initDB() async {
    // Path of database location
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Database creation
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          type TEXT,
          value TEXT
        )
      ''');
    });
  }

  // CREATE SCAN
  Future<int> newScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert('Scans', scan.toJson());
    return res;
  }

  // RETRIEVE SCAN BY ID
  Future<ScanModel?> getScan(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  // RETRIEVE ALL SCANS
  Future<List<ScanModel>?> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  // RETRIEVE ALL SCANS BY TYPE
  Future<List<ScanModel>?> getAllScansByType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);
    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  // UPDATE SCAN
  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final res = await db
        .update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);

    return res;
  }

  // DELETE SCAN BY ID
  Future<int> deleteScan(ScanModel scan) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [scan.id]);

    return res;
  }

  // DELETE ALL SCANS
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');

    return res;
  }

  // -------------------------
  // Example of a raw insert into an SQLite DB (requires SQL sentence).
  // -------------------------

  // Future<int> newScanRaw(ScanModel newScan) async {
  //   final id = newScan.id;
  //   final type = newScan.type;
  //   final value = newScan.value;

  //   final db = await database;

  //   final res = await db.rawInsert('''
  //   INSERT INTO Scans(id, type, value)
  //   VALUES($id, '$type', '$value')
  //   ''');

  //   return res;
  // }
}
