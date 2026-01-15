import 'dart:async';
import 'dart:math';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';
import '../models/stock_history.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('inventory.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE products (
        id $idType,
        name $textType,
        description $textType,
        stock $intType,
        image_path $textType,
        date_added $textType,
        added_by $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE stock_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id $textType,
        timestamp $textType,
        change_amount $intType,
        new_stock $intType,
        FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
      )
    ''');
  }

  // --- Product Operations ---

  Future<void> insertProduct(Product product) async {
    final db = await instance.database;
    String id = await generateUniqueId();
    final productToSave = product.copyWith(id: id);

    await db.insert(
      'products',
      productToSave.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Product?> getProduct(String id) async {
    final db = await instance.database;
    final maps = await db.query('products', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    final result = await db.query('products', orderBy: 'date_added DESC');
    return result.map((json) => Product.fromMap(json)).toList();
  }

  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    return db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(String id) async {
    final db = await instance.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  // --- ID Generation ---

  Future<String> generateUniqueId() async {
    String id = '';
    bool exists = true;
    while (exists) {
      id = _generateRandomId();
      final product = await getProduct(id);
      if (product == null) {
        exists = false;
      }
    }
    return id;
  }

  String _generateRandomId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(5, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }

  // --- History Operations ---

  Future<void> logStockChange(StockHistory history) async {
    final db = await instance.database;
    await db.insert('stock_history', history.toMap());
  }

  Future<List<StockHistory>> getHistoryForProduct(String productId) async {
    final db = await instance.database;
    final result = await db.query(
      'stock_history',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'timestamp DESC',
    );
    return result.map((json) => StockHistory.fromMap(json)).toList();
  }
}
