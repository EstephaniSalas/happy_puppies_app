import 'package:flutter/material.dart';
import 'db_helper.dart'; // Tu archivo DBHelper
import 'user.dart'; // Clase User
import 'dog.dart'; // Clase Dog

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Puppies',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _testDatabase();
  }

  Future<void> _testDatabase() async {
    // Crear un usuario de prueba
    final user = User(
      name: 'Alice',
      email: 'alice@example.com',
      password: 'securepassword',
      phone: '555-1234',
      postalCode: '12345',
    );

    // Insertar usuario en la base de datos
    int userId = await DBHelper.insertUser(user);
    print('Usuario insertado con ID: $userId');

    // Crear un perro de prueba asociado al usuario
    final dog = Dog(
      name: 'Buddy',
      birthDate: DateTime(2018, 6, 15),
      age: 5,
      gender: 'Male',
      weight: 20.5,
      size: 'Medium',
      breed: 'Labrador',
      color: 'Black',
      photo: 'path/to/photo',
    );

    // Asociar el perro al usuario (añadir userId al perro)
    final dogWithUserId = Dog(
      id: userId,
      name: dog.name,
      birthDate: dog.birthDate,
      age: dog.age,
      gender: dog.gender,
      weight: dog.weight,
      size: dog.size,
      breed: dog.breed,
      color: dog.color,
      photo: dog.photo,
    );

    int dogId = await DBHelper.insertDog(dogWithUserId);
    print('Perro insertado con ID: $dogId');

    // Recuperar y mostrar los datos en consola
    final users = await DBHelper.getUsers();
    print('Usuarios: $users');

    final dogs = await DBHelper.getDogs();
    print('Perros: $dogs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Puppies'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _testDatabase,
          child: const Text('Probar Base de Datos'),
        ),
      ),
    );
  }
}
