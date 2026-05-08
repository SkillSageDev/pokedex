import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/item.dart';

class DatabaseService
{
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _db;

  DatabaseService._constructor();

  Future<Database> get database async
  {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final databaseDirpath = await getDatabasesPath();
    final databasePath = join(databaseDirpath, "favorites_database.db");

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            imagePath TEXT NOT NULL,
            description TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Insert
  Future<void> addFavorite(Item item) async
  {
    final db = await database;
    await db.insert('favorites', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Read
  Future<List<Item>> getFavorites() async {
    final db = await database;
    final data = await db.query('favorites');
    return data.map((e) => Item.fromMap(e)).toList();
  }

  // Delete
  Future<void> removeFavorite(int id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
  // Delete (Backup)
  Future<void> removeFavoriteByTitle(String title) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'title = ?',
      whereArgs: [title],
    );
  }
  // Clear all
  Future<void> clearAllFavorites() async {
    final db = await database;
    await db.delete('favorites');
  }
}
// await DatabaseService.instance.removeFavorite(item.id!);