import 'package:app/core/network/local/offline_repository.dart';
import 'package:app/features/stocks/presentation/screens/stock_screen.dart';

class GetStockData {
  final HiveDatabaseService<StockOffline> _hiveDatabaseService;

  GetStockData(this._hiveDatabaseService);

  Future<List<StockOffline>> execute() async {
    return _hiveDatabaseService.getAllItems();
  }
}
