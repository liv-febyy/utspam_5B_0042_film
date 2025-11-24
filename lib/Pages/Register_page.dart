import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernamaController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, dynamic> userData = {};

  void registerUser() {
    if (_formKey.currentState!.validate()) {
      userData = {
        "nama": namaController.text,
        "email": emailController.text,
        "alamat": alamatController.text,
        "phone": phoneController.text,
        "username": usernamaController.text,
        "password": passwordController.text,
      };

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registrasi Berhasil!')));

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Regristasi Pengguna")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: "Nama Lengkap"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "email(@gmail.com)",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "email tidak boleh kosong";
                    }
                    if (!value.endsWith("@gmail.com")) {
                      return "Email harus @gmail.com";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: alamatController,
                  decoration: const InputDecoration(labelText: "Alamat"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Alamat tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Nomor Telepon"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nomor Telepon tidak boleh kosong";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return " Nomor telepon harus angka";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: usernamaController,
                  decoration: const InputDecoration(labelText: "Username"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password (minimal 6 karakter)",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "password tidak boleh kosong";
                    }
                    if (value.length < 6) {
                      return "Password minimal 6 karakter";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: registerUser,
                  child: const Text("Daftar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
