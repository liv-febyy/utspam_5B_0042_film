import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_pemenan_tiket/Pages/Detail_transaksi_page.dart';
import 'package:uts_pemenan_tiket/Providers/Transaction_provider.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<RiwayatPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TransactionProvider>(
        context,
        listen: false,
      ).loadTransaksi(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Pembelian Tiket")),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.TransaksiList.isEmpty) {
            return const Center(child: Text("Belum ada transaksi"));
          }

          return ListView.builder(
            itemCount: provider.TransaksiList.length,
            itemBuilder: (context, index) {
              final trx = provider.TransaksiList[index];

              return Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  leading: Image.network(
                    trx.posterFilm,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(trx.judulFilm),
                  subtitle: Text(
                    "Pembeli: ${trx.namaPembeli}\nTotal: Rp ${trx.total}",
                  ),
                  trailing: Text(
                    trx.status,
                    style: TextStyle(
                      color:
                          trx.status ==
                              "dibatalkan" //
                          ? const Color.fromARGB(255, 183, 61, 253)
                          : const Color.fromARGB(255, 76, 175, 167),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailTransactionPage(transaction: trx),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }, //tambahan
      ),
    );
  }
}
