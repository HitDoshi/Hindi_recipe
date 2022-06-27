import 'package:hindi_recipe/utils/favmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class FavDBHandler {
  static Database? _favdb;

  Future<Database?> get favdb async {

    if (_favdb != null) {
      print("Fav DB EXIST");
      return _favdb;
    }

    _favdb = await initDb();
    print("Fav DB Create");
    return _favdb;
  }

  initDb() async {

    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"fav1.db");
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db , int version) async
  {
    await db.execute(
      "CREATE TABLE fav (id INTEGER PRIMARY KEY AUTOINCREMENT,type_id TEXT NOT NULL,row_id TEXT NOT NULL,name TEXT NOT NULL,sahitya TEXT NOT NULL,kruti TEXT NOT NULL,fav INTEGER NOT NULL)"
    );

    print("Create Fav Table");
  }

  Future<FavModel> insert(FavModel favModel) async{

    var dbClient = await favdb;
    await dbClient?.insert('fav',favModel.toMap());

    print("Inserted");

    return favModel;
  }

  Future<List<FavModel>> readData() async{

    var dbClient = await favdb;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('fav');

    return queryResult.map((e) => FavModel.fromMap(e)).toList() ;
  }

  Future<int> delete(String type_id,String row_id) async{

    var dbClient = await favdb;
    print("Delete-$type_id $row_id");
    return await dbClient!.delete('fav',where: 'type_id=? and row_id=?',whereArgs: [type_id,row_id]);
  }

  Future<int> update(FavModel favModel) async{

    var dbClient = await favdb;
    return await dbClient!.update('fav',
        favModel.toMap(),
        where: 'id=?',whereArgs: [favModel.id]);
  }
}