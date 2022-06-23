import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../utils/datanode.dart';

class DBHandler{

  static const _databaseName = "recipe.db";
  static const _databaseVersion = 1;
  static const table = "recipe";

  static Database? _db;


  Future<Database?> get db async{

    print("hi");

    if(_db!=null){
      return _db;
    }

    _db = await initDataBase();
    return _db;
  }

  initDataBase() async {

    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    //String path = join(documentDirectory.path,"note");
    /*var db = await openDatabase(path,version: 1,onCreate : _onCreate);
    return db;*/

    //var databasePath = await getDatabasesPath();
    String path = join(documentDirectory.path,_databaseName);

    //Check Existing
    bool dbExistsEnglish = await io.File(path).exists();

    if(!dbExistsEnglish){

      print("Start Creating DB Copy");

      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){}

      //Copy

      ByteData data = await rootBundle.load(join("assets",_databaseName));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

      //Write
      await io.File(path).writeAsBytes(bytes,flush: true);
    }
    else{

      print("Already Exists");
    }

    _db = await openDatabase(path);
  }

  _onCreate(Database db , int version) async{

    await db.execute(
      "CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,subtitle TEXT)",
    );
    print("Create");
  }

  Future<DataNode> insert(DataNode dataNode) async{

    var dbClient = await db;

    await dbClient!.insert(table, dataNode.toMap());

    print("Add");

    return dataNode;
  }

}
