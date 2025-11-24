import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Map<String, dynamic>? registeredUser;

  const LoginPage({super.key, this.registeredUser});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() {
    if (_formKey.currentState!.validate()) {
      final data = widget.registeredUser;

      if (data == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Belum ada akun terdaftar!')),
        );
        return;
      }

      final input = loginController.text;
      final password = passwordController.text;

      final emailBenar = input == data['email'];
      final usernameBenar = input == data['username'];
      final passwordBenar = password == data['password'];

      if ((emailBenar || usernameBenar) && passwordBenar) {
        Navigator.pushReplacementNamed(context, '/home', arguments: data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Berhasil! Selamat datang')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email/Username atau password salah!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map?;

    return Scaffold(
      appBar: AppBar(title: const Text("Login Pengguna")),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: loginController,
                decoration: const InputDecoration(
                  labelText: "Email atau username",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 35),

              ElevatedButton(onPressed: loginUser, child: const Text("Login")),
              const SizedBox(height: 25),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: const Text("Belum punya akun?? Daftar di sini"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
