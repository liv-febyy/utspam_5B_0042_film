class Transaksi {
  final String id;
  final String judulFilm;
  final String posterFilm;
  final String jadwal;
  final String namaPembeli;
  final int quantity;
  final String tanggal;
  final int total;
  final String metodePembayaran;
  final String? nomorKartu;
  String status;

  Transaksi({
    required this.id,
    required this.judulFilm,
    required this.posterFilm,
    required this.jadwal,
    required this.namaPembeli,
    required this.quantity,
    required this.tanggal,
    required this.total,
    required this.metodePembayaran,
    this.nomorKartu,
    this.status = "selesai",
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id'],
      judulFilm: json['judulFilm'],
      posterFilm: json['posterFilm'],
      jadwal: json['jadwal'],
      namaPembeli: json['namaPembeli'],
      quantity: json['quantity'],
      tanggal: json['tanggal'],
      total: json['total'],
      metodePembayaran: json['metodePembayaran'],
      nomorKartu: json['nomorKartu'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "judulFilm": judulFilm,
      "posterFilm": posterFilm,
      "jadwal": jadwal,
      "namaPembeli": namaPembeli,
      "quantity": quantity,
      "tanggal": tanggal,
      "total": total,
      "metodePembayaran": metodePembayaran,
      "nomorKartu": nomorKartu,
      "status": status,
    };
  }
}
