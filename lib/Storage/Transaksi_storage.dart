import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts_pemenan_tiket/Models/Transaksi.dart';

class TransaksiStorage {
  static const String key = "transaksi_data";

  static Future<List<Transaksi>> loadTransaksi() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((e) => Transaksi.fromJson(e)).toList();
  }

  static Future<void> saveTransaksi(List<Transaksi> transaksi) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = transaksi.map((e) => e.toJson()).toList();

    prefs.setString(key, json.encode(jsonList));
  }

  static Future<void> tambah(Transaksi transaksi) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    List<dynamic> list = [];
    if (jsonString != null) {
      list = json.decode(jsonString);
    }

    list.add(transaksi.toJson());
    prefs.setString(key, json.encode(list));
  }
}
