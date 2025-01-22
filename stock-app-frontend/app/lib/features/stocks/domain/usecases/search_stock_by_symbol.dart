import 'package:app/features/stocks/domain/entities/stock.dart';
import 'package:app/features/stocks/domain/repositories/stock_repository.dart';
import 'package:dartz/dartz.dart';

class SearchStockBySymbol {
  final StocksRepository repository;

  SearchStockBySymbol(this.repository);

  Future<Either<String, Stock>> call(String apiKey, String symbol) {
    return repository.searchStockBySymbol(apiKey, symbol);
  }
}