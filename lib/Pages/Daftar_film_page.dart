import 'package:flutter/material.dart';
import 'package:uts_pemenan_tiket/Models/Film.dart';

class DaftarFilmPage extends StatelessWidget {
  const DaftarFilmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Film")),
      body: ListView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: dataFilm.length,
        itemBuilder: (context, index) {
          final film = dataFilm[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 25),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      film.poster,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    film.judul,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Genre: ${film.genre}"),
                  Text("Harga: Rp ${film.harga}"),

                  const SizedBox(height: 15),

                  const Text(
                    "jadwal:",
                    style: TextStyle(fontWeight: FontWeight.bold), // jadwal
                  ),

                  Wrap(
                    spacing: 15,
                    children: film.jadwal.map((jam) {
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            // tambah navigator
                            context,
                            '/beli',
                            arguments: {"film": Film, "jadwal": jam},
                          );
                        },
                        child: Text(jam),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        }, //halaman daftar film
      ),
    );
  }
} // daftar film
