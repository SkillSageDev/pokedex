import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/item.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _db;
  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final databaseDirpath = await getDatabasesPath();
    final databasePath = join(databaseDirpath, "favorites_db_v3.db");

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            img TEXT NOT NULL,
            num TEXT NOT NULL,
            type TEXT NOT NULL,
            height TEXT NOT NULL,
            weight TEXT NOT NULL,
            description TEXT NOT NULL,
            species TEXT NOT NULL,
            ability TEXT NOT NULL,
            colorValue INTEGER NOT NULL,
            stats TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> addFavorite(Item item) async {
    final db = await database;
    await db.insert('favorites', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Item>> getFavorites() async {
    final db = await database;
    final data = await db.query('favorites');
    return data.map((e) => Item.fromMap(e)).toList();
  }

  Future<void> removeFavoriteByName(String name) async {
    final db = await database;
    await db.delete('favorites', where: 'name = ?', whereArgs: [name]);
  }
}