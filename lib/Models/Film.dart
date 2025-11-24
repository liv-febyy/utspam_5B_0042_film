class Film {
  //file film
  final String judul;
  final String genre;
  final int harga;
  final String poster;
  final List<String> jadwal;

  Film({
    required this.judul,
    required this.genre,
    required this.harga,
    required this.poster,
    required this.jadwal,
  });
}

List<Film> dataFilm = [
  Film(
    judul: "Ballerina",
    genre: "Action",
    harga: 55000,
    poster: "assets/Posters/BALLERINA.jpg",
    jadwal: ["13:10, 15:00, 16:50"],
  ),

  Film(
    judul: "Wicked",
    genre: "Fantasy",
    harga: 40000,
    poster: "assets/Posters/Wicked.jpg",
    jadwal: ["19:10, 21:00, 12:00"],
  ),

  Film(
    judul: "Jumbo",
    genre: "Petualang",
    harga: 45000,
    poster: "assets/Posters/Jumbo.jpg",
    jadwal: ["15:05, 18:10, 20:35"],
  ),
];
