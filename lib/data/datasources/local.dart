import 'package:sqflite/sqflite.dart';
import 'package:testing/data/models/index.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._internal();

  static Database? _database;

  UserDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/userse.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT NOT NULL,
          last_name TEXT NOT NULL,
          email TEXT NOT NULL,
          avatar TEXT NOT NULL
        )
      ''');
  }

  Future<ResultUserModel> create(ResultUserModel user) async {
    final db = await instance.database;
    await db.insert('users', user.toJson());
    return user;
  }

  Future<ResultUserModel> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'userse',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ResultUserModel.fromJSON(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ResultUserModel>> readAll() async {
    final db = await instance.database;
    const orderBy = 'users.id ASC';
    final result = await db.query('users', orderBy: orderBy);
    return result.map((json) => ResultUserModel.fromJSON(json)).toList();
  }

  Future<int> update(ResultUserModel user) async {
    final db = await instance.database;
    return db.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
