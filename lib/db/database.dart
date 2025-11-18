import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/person.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'contacts.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE persons(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        birthDate TEXT NOT NULL,
        phone TEXT NOT NULL,
        email TEXT NOT NULL,
        address TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertPerson(Person p) async {
    final database = await db;
    return await database.insert('persons', p.toMap());
  }

  Future<List<Person>> getPersons() async {
    final database = await db;
    final maps = await database.query('persons', orderBy: 'lastName, firstName');
    return maps.map((m) => Person.fromMap(m)).toList();
  }

  Future<int> deletePerson(int id) async {
    final database = await db;
    return await database.delete('persons', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final database = await db;
    return await database.delete('persons');
  }
}