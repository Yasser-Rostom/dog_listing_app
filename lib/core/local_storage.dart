import 'dart:async' show Future;

import 'package:dog_listing_app/features/breeds/data/models/breed_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "cached_fav.db";
  static const _databaseVersion = 1;

  static const table = 'favorite';

  static const columnId = '_id';
  static const columnBreedName = 'breed_name';
  static const columnImageUrl = 'image_url';

  //to upgrade db version
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  static final DatabaseHelper _instance = DatabaseHelper._();
  static late Database _db;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await init();

    return _db;
  }

  Future<Database> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return _db;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnBreedName TEXT NOT NULL,
            $columnImageUrl TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }

  Future<List<String>?> fetchFavBreedImages(String breedName) async {
    List<String>? list = [];

    final List<Map<String, dynamic?>> futureMaps = await _db.query(
      table,
      columns: [columnImageUrl],
      where: '$columnBreedName = ?',
      whereArgs: [breedName],
    );
    for (var element in futureMaps) {
      list.add(element[columnImageUrl]);
    }
    // for (var element in futureMaps) {
    //   debugPrint("BreedWithImagesLocalModel: $element");
    //
    //   list.add(BreedWithImagesLocalModel(breedName: element["breed_name"],imageList: element["image_url"]));
    //   debugPrint("$element");
    //
    // }
    //  final maps =  BreedWithImagesLocalModel.fromJson(futureMaps as Map<String, Object?>);
    return list;
  }

  Future<List<String>?> fetchFavoriteBreedNames() async {
    List<String>? list = [];

    final List<Map<String, dynamic?>> futureMaps =
        await _db.query(table, columns: [columnBreedName], distinct: true);
    for (var element in futureMaps) {
      list.add(element[columnBreedName]);
    }

    //  final maps =  BreedWithImagesLocalModel.fromJson(futureMaps as Map<String, Object?>);
    return list;
  }

  Future<int> addFav(BreedWithImagesLocalModel model) async {
    int count = model.imageList.length;
    int numberOfAdded = 0;
    for (int i = 0; i <= (count > 4 ? 4 : count); i++) {
      var value = {
        columnBreedName: model.breedName,
        columnImageUrl: model.imageList[i]
      };

      await _db
          .insert(table, value, conflictAlgorithm: ConflictAlgorithm.replace)
          .then((value) => numberOfAdded = numberOfAdded + value);
    }
    return numberOfAdded;
  }

  Future<int> queryRowCount(String breedName) async {
    final results = await _db.rawQuery(
        'SELECT COUNT(*) FROM $table WHERE $columnBreedName = ?', [breedName]);
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> delete(String breedName) async {
    return await _db.delete(
      table,
      where: '$columnBreedName = ?',
      whereArgs: [breedName],
    );
  }
}
