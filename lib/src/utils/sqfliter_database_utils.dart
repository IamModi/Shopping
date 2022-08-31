import 'package:path/path.dart' as dPath;
import 'package:shopping/src/model/res_all_product.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // only have a single app-wide reference to the database
  static Database? _database;
  String productTable = "Products";
  String productCartTable = "productCartTable";

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _init();
    return _database!;
  }

  _init() async {
    var databasesPath = await getDatabasesPath();
    var path = dPath.join(databasesPath, "Shopping.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        'CREATE TABLE $productTable (id INTEGER, slug TEXT, featured_image TEXT, title TEXT, description TEXT, price INTEGER, status TEXT, created_at TEXT)');

    await db.execute(
        'CREATE TABLE $productCartTable (id INTEGER, slug TEXT, featured_image TEXT, title TEXT, description TEXT, price INTEGER, status TEXT, created_at TEXT)');
  }

  //insert products to Local database
  Future insertProducts(ProductDetails productDetails) async {
    var dbClient = await database;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $productTable ');
    var contain = list.where((element) => element['id'] == productDetails.id);
    if (contain.isEmpty) {
      dbClient.insert(productTable, productDetails.toJson());
    } else {}
  }

  //For cart items
  Future insertCartProducts(ProductDetails productDetails) async {
    var dbClient = await database;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM $productCartTable ');
    var contain = list.where((element) => element['id'] == productDetails.id);
    if (contain.isEmpty) {
      dbClient.insert(productCartTable, productDetails.toJson());
    }
  }

  //getting all products details
  Future<List<ProductDetails>> getProducts() async {
    var dbClient = await database;
    var records = <ProductDetails>[];

    var productList = await dbClient.rawQuery('Select * from $productTable');

    if (productList.isNotEmpty) {
      for (var e in productList) {
        records.add(ProductDetails.fromJson(e));
      }
      return records;
    }
    return records;
  }

  Future<List<ProductDetails>> getCartProducts() async {
    var dbClient = await database;
    var records = <ProductDetails>[];
    var list = await dbClient.rawQuery('Select * from $productCartTable');

    if (list.isNotEmpty) {
      for (var e in list) {
        records.add(ProductDetails.fromJson(e));
      }
      return records;
    }
    return records;
  }

  Future<int> delete(int productId) async {
    var dbClient = await database;

    return await dbClient
        .delete(productCartTable, where: "id = ?", whereArgs: [productId]);
  }
}
