import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gezdunyayigorkonyayi/model/lokasyon.dart';

class LokasyonDatabase {
  static final LokasyonDatabase instance = LokasyonDatabase._init();

  static Database? _database;

  LokasyonDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'lokasyonlar.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableLokasyonlar ( 
  ${LokasyonFields.id} $idType, 
  ${LokasyonFields.baslik} $textType,
  ${LokasyonFields.aciklama} $textType,
  ${LokasyonFields.ani} $textType,
  ${LokasyonFields.puan} $textType,
  ${LokasyonFields.dataLat} $textType,
  ${LokasyonFields.dataLon} $textType,
  ${LokasyonFields.tarih} $textType
  )
''');
  }

  Future<Lokasyon> create(Lokasyon lokasyon) async {
    final db = await instance.database;
    final id = await db.insert(tableLokasyonlar, lokasyon.toJson());
    return lokasyon.copy(id: id);
  }

  Future<Lokasyon> readLokasyon(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableLokasyonlar,
      columns: LokasyonFields.values,
      where: '${LokasyonFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Lokasyon.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Lokasyon>> readAllLokasyonlar() async {
    final db = await instance.database;

    final orderBy = '${LokasyonFields.tarih} ASC';
    final result = await db.query(tableLokasyonlar, orderBy: orderBy);

    return result.map((json) => Lokasyon.fromJson(json)).toList();
  }

  Future<int> update(Lokasyon lokasyon) async {
    final db = await instance.database;
    return db.update(
      tableLokasyonlar,
      lokasyon.toJson(),
      where: '${LokasyonFields.id} = ?',
      whereArgs: [lokasyon.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableLokasyonlar,
      where: '${LokasyonFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
