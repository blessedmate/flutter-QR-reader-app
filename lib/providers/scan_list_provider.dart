import 'package:flutter/material.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:qr_reader_app/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    // Assign id given by DB to new scan
    newScan.id = id;

    if (selectedType == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }
  }

  loadScans() async {
    final loaded = await DBProvider.db.getAllScans();
    if (loaded != null) {
      scans = [...loaded];
    }
    notifyListeners();
  }

  loadScansByType(String type) async {
    final loaded = await DBProvider.db.getAllScansByType(type);
    selectedType = type;
    if (loaded != null) {
      scans = [...loaded];
    } else {
      scans = [];
    }
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    loadScansByType(selectedType);
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }
}
