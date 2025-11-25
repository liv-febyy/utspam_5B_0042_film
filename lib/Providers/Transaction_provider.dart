import 'package:flutter/material.dart';
import 'package:uts_pemenan_tiket/Models/Transaksi.dart';
import 'package:uts_pemenan_tiket/Storage/Transaksi_storage.dart';

//transaksi
class TransactionProvider with ChangeNotifier {
  List<Transaksi> TransaksiList = [];

  Future<void> loadTransaksi() async {
    TransaksiList = await TransaksiStorage.loadTransaksi();
    notifyListeners();
  }

  Future<void> addTransaksi(Transaksi transaksi) async {
    TransaksiList.add(transaksi);
    await TransaksiStorage.saveTransaksi(TransaksiList);
    notifyListeners();
  }

  Future<void> updateTransaksi(Transaksi update) async {
    final index = TransaksiList.indexWhere((t) => t.id == update.id);
    if (index != -1) {
      TransaksiList[index] = update;
      await TransaksiStorage.saveTransaksi(TransaksiList);
      notifyListeners();
    }
  }

  Future<void> deleteTransaksi(String id) async {
    TransaksiList.removeWhere((t) => t.id == id);
    await TransaksiStorage.saveTransaksi(TransaksiList);
    notifyListeners();
  }
}
// transaksi ke provider