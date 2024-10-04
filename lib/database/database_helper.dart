import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recordatorios.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE recordatorios(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo TEXT,
      descripcion TEXT,
      fecha TEXT,
      hora TEXT
    )
    ''');
  }

  Future<int> insertRecordatorio(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('recordatorios', row);
  }

  Future<List<Map<String, dynamic>>> getRecordatorios() async {
    final db = await instance.database;
    return await db.query('recordatorios', orderBy: 'fecha ASC, hora ASC');
  }

  Future<List<Map<String, dynamic>>> getRecordatoriosPorFecha(String fecha) async {
    final db = await instance.database;
    return await db.query('recordatorios', where: 'fecha = ?', whereArgs: [fecha], orderBy: 'hora ASC');
  }

  Future<int> deleteRecordatorio(int id) async {
    final db = await instance.database;
    return await db.delete('recordatorios', where: 'id = ?', whereArgs: [id]);
  }
}
