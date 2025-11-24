import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic>? user;

  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final nama = widget.user?['nama'] ?? 'Pengguna';

    return Scaffold(
      appBar: AppBar(title: const Text("Aplikasi Pembelian Tiket Film")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hallo, $nama 👋",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            Expanded(
              child: ListView(
                children: [
                  menuItem(
                    icon: Icons.movie,
                    title: "Daftar Film",
                    onTap: () {
                      Navigator.pushNamed(context, '/film');
                    },
                  ),

                  menuItem(
                    icon: Icons.shopping_cart,
                    title: "Beli Tiket",
                    onTap: () {
                      Navigator.pushNamed(context, '/beli');
                    },
                  ),

                  menuItem(
                    icon: Icons.history,
                    title: "Riwayat Pembelian",
                    onTap: () {
                      Navigator.pushNamed(context, '/riwayat');
                    },
                  ),

                  menuItem(
                    icon: Icons.person,
                    title: "Profil",
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/Profil',
                        arguments: widget.user,
                      );
                    },
                  ),

                  menuItem(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Logout berhasil!")),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem({
    required IconData icon,
    required String title,
    required Function() onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 35),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20),
        onTap: onTap,
      ),
    );
  }
}
