import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static setDatabase() async {
    var directory = await getDatabasesPath();
    var path = join(directory, 'db');
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreatingDatabase,
    );
    return database;
  }

  static onCreatingDatabase(Database database, int version) async {
    await database.execute('''
        CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        email TEXT,
        senha TEXT
        )''');

    await database.execute('''
        CREATE TABLE imc(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        peso REAL,
        altura REAL,
        imc TEXT
        )''');

    await database.execute('''
        CREATE TABLE temp(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        celsius REAL,
        tipo TEXT,
        valor REAL
        )''');
  }

  static Future<int> cadastro({required nome, required email, required senha}) async {
    Database db = await setDatabase();
    var insert = await db.insert('usuarios', {
      'id': null,
      'nome': nome.toString(),
      'email': email.toString(),
      'senha': senha.toString(),
    });
    return insert;
  }

  static Future<List<Map<String, dynamic>>> login({required email, required senha}) async {
    Database db = await setDatabase();
    var lista = await db.rawQuery("SELECT * FROM usuarios WHERE email = ? AND senha = ?", [email, senha]);
    return lista;
  }

  static Future<int> newTemp({required String email, required double celsius, required String tipo, required double valor}) async {
    Database db = await setDatabase();
    var insert = await db.insert('temp', {
      'id': null,
      'email': email,
      'celsius': celsius,
      'tipo': tipo,
      'valor': valor,
    });
    return insert;
  }

  static Future<int> newImc({required String email, required double peso, required double altura, required String imc}) async {
    Database db = await setDatabase();
    var insert = await db.insert('imc', {
      'id': null,
      'email': email,
      'peso': peso,
      'altura': altura,
      'imc': imc,
    });
    return insert;
  }
}
