import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: const Text(
          "Pantalla de Registro",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
