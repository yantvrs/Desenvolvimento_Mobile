import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'filmes.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE filmes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        ano INTEGER,
        direcao TEXT,
        resumo TEXT,
        url_cartaz TEXT,
        nota REAL
      )
    ''');
  }

  Future<int> insertFilme(Map<String, dynamic> filme) async {
    final db = await database;
    return await db.insert('filmes', filme);
  }

  Future<List<Map<String, dynamic>>> getFilmes() async {
    final db = await database;
    return await db.query('filmes');
  }

  Future<int> updateFilme(Map<String, dynamic> filme) async {
    final db = await database;
    return await db.update(
      'filmes',
      filme,
      where: 'id = ?',
      whereArgs: [filme['id']],
    );
  }

  Future<int> deleteFilme(int id) async {
    final db = await database;
    return await db.delete(
      'filmes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
