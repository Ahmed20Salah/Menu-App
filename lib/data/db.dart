import 'dart:io';

import 'package:menu_app/models/category.dart';
import 'package:menu_app/models/item.dart';
import 'package:menu_app/models/order.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class MenuDatabase {
  static final MenuDatabase _instance = MenuDatabase.internal();

  MenuDatabase.internal();
  factory MenuDatabase() => _instance;

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'main.db');
    var ourdb = await openDatabase(path,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
    return ourdb;
  }

  static Future _onConfigure(Database db) async {
    // await db.execute('PRAGMA foreign_keys = ON');
  }

  _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE Items(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , description TEXT , price double , category INTEGER  , image TEXT , FOREIGN KEY(category) REFERENCES Category(id))');
    await db.execute(
        'CREATE TABLE Category(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT UNIQUE )');
    // await db.execute(
    //     'CREATE TABLE Orders(id INTEGER PRIMARY KEY AUTOINCREMENT, Items TEXT , Table INTEGER , total INTEGER )');
  }

  Future<int> insertItem(Item item) async {
    var ourdb = await db;
    return ourdb.insert('Items', item.toMap());
  }

  Future<int> insertCategory(Map<String, dynamic> name) async {
    var ourdb = await db;
    return ourdb.insert('Category', name);
  }

  Future getCategory() async {
    var ourdb = await db;

    return ourdb.rawQuery('select * from  Category');
  }

  Future getItems() async {
    var ourdb = await db;

    return ourdb.rawQuery('select * from  Items');
  }

  Future deleteItem(Item item) async {
    var ourdb = await db;
    return ourdb.delete('Items', where: "id = ? ", whereArgs: [item.id]);
  }

  Future deleteCategory(Category category) async {
    var ourdb = await db;
    return ourdb.delete('Category', where: "id = ? ", whereArgs: [category.id]);
  }

  Future editCategory(Category category) async {
    var ourdb = await db;
    return ourdb.update('Category', category.toMap(),
        where: 'id = ? ', whereArgs: [category.id]);
  }

  Future editItem(Item item) async {
    var ourdb = await db;
    return ourdb
        .update('Items', item.toMap(), where: 'id = ? ', whereArgs: [item.id]);
  }

  // Future addOrder(Order order) async {
  //   var ourDb = await db;
  //   return ourDb.insert('Orders', order.toMap());
  // }

  // Future getOrders() async {
  //   var ourDb = await db;
  //   return ourDb.execute('select * from  Orders');
  // }
}
