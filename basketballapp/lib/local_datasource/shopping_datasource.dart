import 'dart:async';
import 'dart:io';
import 'package:basketballapp/model/basket_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "basket.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Basket(id INTEGER PRIMARY KEY, title TEXT, price REAL, image TEXT, count INTEGER)");
  }

  // Insert a product into the database
  Future<int> insertBasket(BasketModel model) async {
    var dbClient = await db;
    int res = await dbClient!.insert("Basket", model.toJson());
    return res;
  }

  Future<int> updateBasket(BasketModel model) async {
    var dbClient = await db;
    int res = await dbClient!.update("Basket", model.toJson(),
        where: "id = ?", whereArgs: [model.id]);
    return res;
  }

  // Get all products from the database
  Future<List<BasketModel>> getBaskets() async {
    await deleteDatabase("Basket");
    var dbClient = await db;
    List<Map<String, dynamic>> list = await dbClient!.query("Basket");
    List<BasketModel> baskets = [];
    for (int i = 0; i < list.length; i++) {
      baskets.add(BasketModel.fromJson(list[i]));
    }
    return baskets;
  }

  // Delete a product from the database
  Future<int> deleteBasket(int id) async {
    var dbClient = await db;
    int res =
        await dbClient!.delete("Basket", where: "id = ?", whereArgs: [id]);
    return res;
  }

  // Other database operations can be added here as needed
}
