import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_pemenan_tiket/Models/Transaksi.dart';
import 'package:uts_pemenan_tiket/Providers/Transaction_provider.dart';

class EditTransactionPage extends StatefulWidget {
  final Transaksi transaction;

  const EditTransactionPage({super.key, required this.transaction});

  @override
  State<EditTransactionPage> createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController qtyController;
  late TextEditingController cardController;

  String paymentMethod = "";
  int total = 0;

  @override
  void initState() {
    super.initState();

    qtyController = TextEditingController(
      text: widget.transaction.quantity.toString(),
    );
    cardController = TextEditingController(
      text: widget.transaction.nomorKartu ?? "",
    );

    paymentMethod = widget.transaction.metodePembayaran;
    total = widget.transaction.total;
  }

  void updateTotal() {
    int price = widget.transaction.total ~/ widget.transaction.quantity;
    int qty = int.tryParse(qtyController.text) ?? 1;

    setState(() {
      total = price * qty;
    });
  }

  void saveEdit() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<TransactionProvider>(context, listen: false);

      final updated = Transaksi(
        id: widget.transaction.id,
        judulFilm: widget.transaction.judulFilm,
        posterFilm: widget.transaction.posterFilm,
        jadwal: widget.transaction.jadwal,
        namaPembeli: widget.transaction.namaPembeli,
        quantity: int.parse(qtyController.text),
        tanggal: widget.transaction.tanggal,
        total: total,
        metodePembayaran: paymentMethod,
        nomorKartu: paymentMethod == "Kartu Debit/Kredit"
            ? cardController.text
            : null,
        status: widget.transaction.status,
      );

      await provider.updateTransaksi(updated);

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Pembelian Tiket")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Qty
              TextFormField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Jumlah Pembelian Tiket",
                ),
                onChanged: (v) => updateTotal(),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Tidak boleh kosong";
                  if (int.tryParse(v) == null || int.parse(v) <= 0) {
                    return "Jumlah harus lebih dari 0";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Payment Method
              DropdownButtonFormField(
                value: paymentMethod,
                items: const [
                  DropdownMenuItem(value: "Cash", child: Text("Cash")),
                  DropdownMenuItem(
                    value: "Kartu Debit/Kredit",
                    child: Text("Kartu Debit/Kredit"),
                  ),
                ],
                decoration: const InputDecoration(
                  labelText: "Metode Pembayaran",
                ),
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Card number (only if card)
              if (paymentMethod == "Kartu Debit/Kredit")
                TextFormField(
                  controller: cardController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Nomor Kartu (16 digit)",
                  ),
                  validator: (v) {
                    if (paymentMethod != "Kartu Debit/Kredit") return null;

                    if (v == null || v.isEmpty) {
                      return "Nomor kartu wajib diisi";
                    }
                    if (v.length != 16) return "Harus 16 digit";
                    if (int.tryParse(v) == null) {
                      return "Harus angka";
                    }
                    return null;
                  },
                ),

              const SizedBox(height: 20),

              // Total (real time)
              Text(
                "Total : Rp $total",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // Save button
              ElevatedButton(
                onPressed: saveEdit,
                child: const Text("Simpan Perubahan"),
              ),

              const SizedBox(height: 15),

              // Cancel button
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
