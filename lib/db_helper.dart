import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dog.dart'; // Importa tu modelo Dog
import 'user.dart'; // Importa tu modelo User

class DBHelper {
  static Database? _database;

  // Inicializar la base de datos
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'happy_puppies.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Crear tabla de usuarios
        db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT,
            phone TEXT,
            postalCode TEXT
          )
        ''');

        // Crear tabla de perros
        db.execute('''
          CREATE TABLE dogs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            birthDate TEXT,
            age INTEGER,
            gender TEXT,
            weight REAL,
            size TEXT,
            breed TEXT,
            color TEXT,
            photo TEXT,
            userId INTEGER,
            FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE
          )
        ''');
      },
    );
    return _database!;
  }

  // Métodos para Usuarios
  static Future<int> insertUser(User user) async {
    final db = await getDatabase();
    return await db.insert('users', user.toMap());
  }

  static Future<List<User>> getUsers() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> userMaps = await db.query('users');
    return userMaps.map((map) => User.fromMap(map)).toList();
  }

  // Métodos para Perros
  static Future<int> insertDog(Dog dog) async {
    final db = await getDatabase();
    return await db.insert('dogs', dog.toMap());
  }

  static Future<List<Dog>> getDogs() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> dogMaps = await db.query('dogs');
    return dogMaps.map((map) => Dog.fromMap(map)).toList();
  }
}
