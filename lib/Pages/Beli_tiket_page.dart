import 'package:flutter/material.dart';
import 'package:uts_pemenan_tiket/Models/Film.dart';
import 'package:uts_pemenan_tiket/Models/Transaksi.dart';
import 'package:uts_pemenan_tiket/Storage/Transaksi_storage.dart';

class BeliTiketPage extends StatefulWidget {
  const BeliTiketPage({super.key});

  @override
  State<BeliTiketPage> createState() => _BeliTiketPageState();
}

class _BeliTiketPageState extends State<BeliTiketPage> {
  final _formKey = GlobalKey<FormState>();

  int quantity = 1;
  String metode = "Cash";
  TextEditingController kartuController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  int total = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final Film film = args['film'];
    final String jadwal = args['jadwal'];
    final String namaUser = args['nama'];

    total = film.harga * quantity;

    return Scaffold(
      appBar: AppBar(title: const Text("Pembelian Tiket")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  film.poster,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                film.judul,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Jadwal: $jadwal"), // Jadwal
              Text("Harga: Rp ${film.harga}"),
              const SizedBox(height: 25),

              TextFormField(
                initialValue: namaUser,
                readOnly: true,
                decoration: const InputDecoration(labelText: "Nama Pembeli"),
              ),
              const SizedBox(height: 25),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Jumlah Tiket"),
                initialValue: "1",
                validator: (v) {
                  if (v == null || v.isEmpty) return "Wajib diisi";
                  if (int.tryParse(v) == null) return "Harus angka";
                  if (int.parse(v) < 1) return "Minimal 1";
                },
                onChanged: (v) {
                  setState(() {
                    quantity = int.tryParse(v) ?? 1;
                  });
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: tanggalController,
                decoration: const InputDecoration(
                  labelText: "tangal Pembelian (DD-MM-YYYY)",
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Wajib Diisi";
                  if (!RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(v))
                    return "Format salah";
                  return null;
                },
              ),

              const Text(
                "Metode Pembayaran:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ), // metode pembayaran
              ),
              DropdownButton<String>(
                value: metode,
                onChanged: (v) {
                  setState(() {
                    metode = v!;
                  });
                },
                items: const [
                  DropdownMenuItem(value: "Cash", child: Text("Cash")),
                  DropdownMenuItem(
                    value: "Kartu",
                    child: Text("Kartu Debit/Kredit"),
                  ),
                ],
              ),

              // NOMOR KARTU (MUNCUL HANYA KALO PILIH KARTU)
              if (metode == "Kartu") ...[
                const SizedBox(height: 20),
                TextFormField(
                  controller: kartuController,
                  decoration: const InputDecoration(
                    labelText: "Nomor Kartu (16 digit)",
                  ),
                  validator: (v) {
                    if (metode == "Kartu") {
                      if (v == null || v.isEmpty) return "Wajib diisi";
                      if (!RegExp(r'^\d{16}$').hasMatch(v))
                        return "Harus 16 digit angka";
                    }
                    return null;
                  },
                ),
              ],

              const SizedBox(height: 30),

              Text(
                "Total: Rp $total", //toatal
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // TOMBOL BELI
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final transaksi = Transaksi(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        judulFilm: film.judul,
                        posterFilm: film.poster,
                        jadwal: jadwal,
                        namaPembeli: namaUser,
                        quantity: quantity,
                        tanggal: tanggalController.text,
                        total: total,
                        metodePembayaran: metode,
                        nomorKartu: metode == "Kartu"
                            ? kartuController.text
                            : null,
                      );

                      // SIMPAN
                      TransaksiStorage.tambah(transaksi);

                      Navigator.pushReplacementNamed(context, '/riwayat');
                    }
                  },
                  child: const Text("Selesai & Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
