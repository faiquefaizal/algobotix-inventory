import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:algo_botix_assignment/models/product_model.dart';
import 'package:algo_botix_assignment/models/stock_history_model.dart';
import 'package:algo_botix_assignment/core/utils/helper_funtions.dart';

///Implements the Singleton pattern to maintain a single SQLite connection.
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();
  // Lazy initialization of the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('inventory.db');
    return _database!;
  }

  /// Initializes the SQLite database and defines the schema.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// internal method to create the database schema.
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

  /// Inserts a new product into the database.
  ///
  /// Generates a unique ID for the product before saving.
  Future<void> insertProduct(Product product) async {
    final db = await instance.database;
    String id = await _generateUniqueId();
    final productToSave = product.copyWith(id: id);

    await db.insert('products', productToSave.toMap());
  }

  /// Retrieves a single product by its [id].
  ///
  /// Returns `null` if the product is not found.
  Future<Product?> getProduct(String id) async {
    final db = await instance.database;
    final maps = await db.query('products', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    }
    return null;
  }

  /// Retrieves all products from the database.
  ///
  /// Products are sorted by [date_added] in descending order (newest first).
  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    final result = await db.query('products', orderBy: 'date_added DESC');
    return result.map((json) => Product.fromMap(json)).toList();
  }

  /// Updates an existing [product] in the database.
  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    return db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  /// Deletes a product from the database by its [id].

  Future<int> deleteProduct(String id) async {
    final db = await instance.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  /// Generates a unique 6-character alphanumeric ID.
  ///
  /// Checks against existing products and repeats generation until a unique ID is found.
  Future<String> _generateUniqueId() async {
    String id = '';
    bool exists = true;
    while (exists) {
      id = generateRandomId();
      final product = await getProduct(id);
      if (product == null) {
        exists = false;
      }
    }
    return id;
  }

  /// Logs a stock change event (increase/decrease) in the history table.
  Future<void> logStockChange(StockHistory history) async {
    final db = await instance.database;
    await db.insert('stock_history', history.toMap());
  }

  /// Retrieves the stock history for a specific product by [productId].
  ///
  /// Logs are sorted by [timestamp] in descending order (newest first).
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
