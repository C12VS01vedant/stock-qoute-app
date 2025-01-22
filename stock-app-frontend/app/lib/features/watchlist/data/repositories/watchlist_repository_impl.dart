import 'package:app/core/network/local/offline_repository.dart';
import 'package:app/features/stocks/presentation/screens/stock_screen.dart';
import 'package:app/features/watchlist/domain/repositories/watchlist_repository.dart';

class StockRepositoryImpl implements StockRepository {
  final HiveDatabaseService<StockOffline> _hiveDatabaseService;

  StockRepositoryImpl(this._hiveDatabaseService);

  @override
  Future<void> saveStock(StockOffline stock) async {
    await _hiveDatabaseService.addItem(stock);
  }

  @override
  Future<List<StockOffline>> getAllStocks() async {
    return _hiveDatabaseService.getAllItems();
  }

  @override
  Future<void> deleteStock(String symbol) async {
    await _hiveDatabaseService.deleteStock(symbol);
  }
}
