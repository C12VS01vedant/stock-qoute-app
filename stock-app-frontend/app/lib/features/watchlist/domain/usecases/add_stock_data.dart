import 'package:app/core/network/local/offline_repository.dart';
import 'package:app/features/stocks/presentation/screens/stock_screen.dart';

class AddStockData {
  final HiveDatabaseService<StockOffline> _hiveDatabaseService;

  AddStockData(this._hiveDatabaseService);

  Future<void> execute(StockOffline stock) async {
    await _hiveDatabaseService.addItem(stock);
  }
}
