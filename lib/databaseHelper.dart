// ignore: file_names
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'your_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imagePath TEXT
      )
    ''');
  }

  Future<int> insertImage(String imagePath) async {
    final db = await database;
    return await db.insert('images', {'imagePath': imagePath});
  }

  Future<List<String>> getAllImagePaths() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('images');

    return List<String>.from(maps.map((map) => map['imagePath']));
  }
}