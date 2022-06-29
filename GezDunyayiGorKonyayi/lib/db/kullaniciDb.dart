import 'dart:io';
import 'package:gezdunyayigorkonyayi/model/kullanici.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class KullaniciDatabase {
  static final KullaniciDatabase instance = KullaniciDatabase._init();

  static Database? _database;

  KullaniciDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'kullanicilar.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableUsers  ( 
  ${UsersFields.id} $idType, 
  ${UsersFields.email} $textType,
  ${UsersFields.password} $textType 
  )
''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, user.toJson());
    return user.copy(id: id);
  }

  Future<User> readUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UsersFields.values,
      where: '${UsersFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> readAllUsers() async {
    final db = await instance.database;

    final result = await db.query(tableUsers);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> update(User user) async {
    final db = await instance.database;

    return db.update(
      tableUsers,
      user.toJson(),
      where: '${UsersFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUsers,
      where: '${UsersFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future deleteAll() async {
    final db = await instance.database;

    return await db.execute("delete from " + tableUsers);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
