import 'package:flutter/material.dart';
import 'register_screen.dart'; // Importa la pantalla de registro
import '../db/db_helper.dart'; // Ruta relativa para db_helper.dart
import '../models/user.dart'; // Ruta relativa para user.dart

import 'package:sqflite/sqflite.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


void checkDatabasePath() async {
  final dbPath = await getDatabasesPath();
  print("Ruta de la base de datos: $dbPath");
}


  // Método para validar login con SQLite
  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor, llena todos los campos',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Verificar usuario en la base de datos
    final user = await DBHelper.loginUser(email, password);

    if (user != null) {
      // Login exitoso, redirigir a la pantalla principal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Bienvenido, ${user.name}!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(context, '/home'); // Redirige al home
    } else {
      // Credenciales inválidas
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email o contraseña incorrectos',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Parte superior (blanca con logo y formulario)
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/images/happypuppies_negro.png',
                        height: 50,
                      ),
                      const SizedBox(height: 50),
                      // Título
                      const Text(
                        "Iniciar sesión",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Campo de correo electrónico
                      _InputField(
                        controller: emailController,
                        icon: Icons.email,
                        hintText: "email@aaa.com",
                        label: "Correo electrónico",
                      ),
                      const SizedBox(height: 25),
                      // Campo de contraseña
                      _InputField(
                        controller: passwordController,
                        icon: Icons.lock,
                        hintText: "*******",
                        label: "Contraseña",
                        obscureText: true,
                      ),
                      // Olvidar contraseña
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "¿Has olvidado tu contraseña?",
                            style: TextStyle(
                              fontSize: 14,
                              height: 0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      // Botón de iniciar sesión
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login, // Llama a _login
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "ENTRAR",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Texto para crear cuenta
                      Column(
                        children: [
                          const Text(
                            "¿No tienes una cuenta?",
                            style: TextStyle(fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navegar a la pantalla de registro
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Crea tu cuenta aquí.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 255, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Parte inferior (imagen de fondo)
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login_background.png'),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Widget reutilizable para los campos de entrada
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final String label;
  final bool obscureText;

  const _InputField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.label,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hintText,
          labelText: label,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
