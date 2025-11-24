import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_pemenan_tiket/Models/Transaksi.dart';
import 'package:uts_pemenan_tiket/Providers/Transaction_provider.dart';
import 'package:uts_pemenan_tiket/Pages/Edit_transaktion_page.dart';

class DetailTransactionPage extends StatelessWidget {
  final Transaksi transaction;

  const DetailTransactionPage({super.key, required this.transaction});

  String maskCardNumber(String? number) {
    if (number == null) return "-";
    if (number.length < 16) return number;

    return "************" + number.substring(12);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Pembelian")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Poster
            Center(
              child: Image.network(
                transaction.posterFilm,
                width: 180,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Film Title
            Text(
              transaction.judulFilm,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            // Schedule
            Text(
              "Jadwal: ${transaction.jadwal}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            // Buyer
            Text(
              "Nama Pembeli: ${transaction.namaPembeli}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            // Quantity
            Text(
              "Jumlah Tiket: ${transaction.quantity}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            // Date
            Text(
              "Tanggal Pembelian: ${transaction.tanggal}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            // Total
            Text(
              "Total Pembayaran: Rp ${transaction.total}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Payment Method
            Text(
              "Metode Pembayaran: ${transaction.metodePembayaran}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            // Card Number (masked)
            if (transaction.metodePembayaran == "Kartu Debit/Kredit")
              Text(
                "Nomor Kartu: ${maskCardNumber(transaction.nomorKartu)}",
                style: const TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 20),

            // Status
            Text(
              "Status: ${transaction.status}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: transaction.status == "dibatalkan"
                    ? const Color.fromARGB(255, 65, 39, 216)
                    : Colors.green,
              ),
            ),

            const SizedBox(height: 30),

            // CANCEL BUTTON
            if (transaction.status != "dibatalkan")
              ElevatedButton(
                onPressed: () async {
                  final provider = Provider.of<TransactionProvider>(
                    context,
                    listen: false,
                  );

                  // Update status menjadi dibatalkan
                  final Transaksi updated = Transaksi(
                    id: transaction.id,
                    judulFilm: transaction.judulFilm,
                    posterFilm: transaction.posterFilm,
                    jadwal: transaction.jadwal,
                    namaPembeli: transaction.namaPembeli,
                    quantity: transaction.quantity,
                    tanggal: transaction.tanggal,
                    total: transaction.total,
                    metodePembayaran: transaction.metodePembayaran,
                    nomorKartu: transaction.nomorKartu,
                    status: "dibatalkan",
                  );

                  await provider.updateTransaksi(updated);

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  "Batalkan Transaksi",
                  style: TextStyle(color: Colors.white),
                ),
              ),

            const SizedBox(height: 15),

            // EDIT BUTTON — hanya muncul jika status selesai
            if (transaction.status == "selesai")
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EditTransactionPage(transaction: transaction),
                    ),
                  );
                },
                child: const Text("Edit Transaksi"),
              ),

            const SizedBox(height: 10),

            // BACK BUTTON
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Kembali ke Riwayat"),
            ),
          ],
        ),
      ),
    );
  }
}
