import 'package:app/features/stocks/presentation/screens/stock_screen.dart';

abstract class StockRepository {
  Future<void> saveStock(StockOffline stock);
  Future<void> deleteStock(String symbol);
  Future<List<StockOffline>> getAllStocks();
}
