import 'package:app/features/stocks/presentation/screens/stock_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabaseService<T> {
  late Box<T> _box;

  static Future<void> initializeHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  Future<void> openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<T>(boxName);
    } else {
      _box = Hive.box<T>(boxName);
    }
  }

  /// Adds an item to the box.
  Future<void> addItem(T item) async {
    await _box.add(item);
  }

  /// Updates an item in the box at the specified index.
  Future<void> updateItem(int index, T item) async {
    await _box.putAt(index, item);
  }

  /// Deletes an item from the box at the specified index.
  Future<void> deleteItem(int index) async {
    await _box.deleteAt(index);
  }

  /// Retrieves an item from the box at the specified index.
  T? getItem(int index) {
    return _box.getAt(index);
  }

  /// Retrieves all items from the box.
  List<T> getAllItems() {
    return _box.values.toList();
  }

  /// Deletes all items from the box.
  Future<void> clearBox() async {
    await _box.clear();
  }

  /// Closes the box.
  Future<void> closeBox() async {
    await _box.close();
  }


  // for particular delete stock.
   Future<void> deleteStock(String symbol) async {
    final box = await Hive.openBox<StockOffline>('stocks');
    await box.delete(symbol);
  }
}