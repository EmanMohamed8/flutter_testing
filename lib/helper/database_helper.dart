import 'dart:html';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_project/helper/constance.dart';
import 'package:test_project/models/user_model.dart';

class DataBaseHelper{
  DataBaseHelper._(); // empty constructor
  static final DataBaseHelper db = DataBaseHelper._();
  static late Database _database;
  Future <Database> get database async{
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }
  initDB() async{
    String path = join(await getDatabasesPath(), "UserData.db");
    await openDatabase(path, version: 1, onCreate: (Database db, int version) async{
      await db.execute('''
        CREATE TABLE $tableUser(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL,
          $columnPhone TEXT NOT NULL,
          $columnEmail TEXT NOT NULL,
        )
      ''');
    });
  }

  Future<void> insertUser(UserModel user) async{
    var dbClient = await database;
    await dbClient.insert(
      tableUser,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateUser(UserModel user) async{
    var dbClient = await database;
    await dbClient.update(
      tableUser,
      user.toJson(),
      where: '$columnId = ?',
      whereArgs:  [user.id],
    );
  }

  Future<UserModel> getUser(int id) async{
    var dbClient = await database;
    List<Map<String, dynamic>> maps =  await dbClient.query(
        tableUser,
        where: '$columnId',
        whereArgs: [id]
    );
    if(maps.length > 0){
      return UserModel.fromJson(maps.first);
    } else{
      // null;
      return UserModel(id: 0, name: '', email: '', phone: '');
    }
  }

  Future<List<UserModel>> getAllUsers() async{
    var dbClient = await database;
    List<Map<String, dynamic>> maps =  await dbClient.query(tableUser);
    return maps.isNotEmpty ?
        maps.map((user) => UserModel.fromJson(user)).toList() : [];
  }

  Future<void> deleteUser(int id) async{
    var dbClient = await database;
    await dbClient.delete(
      tableUser,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}