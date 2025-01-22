import 'package:dartz/dartz.dart';
import '../entities/stock.dart';

abstract class StocksRepository {
  Future<Either<String, List<Stock>>> getDefaultStocks(
      String apiKey, String symbols);

  Future<Either<String, Stock>> searchStockBySymbol(
      String apiKey, String symbol);
}
