import 'package:app/features/stocks/domain/entities/stock.dart';
import 'package:app/features/stocks/domain/repositories/stock_repository.dart';
import 'package:dartz/dartz.dart';

class GetDefaultStocks {
  final StocksRepository repository;

  GetDefaultStocks(this.repository);

  Future<Either<String, List<Stock>>> call(String apiKey, String symbols) {
    return repository.getDefaultStocks(apiKey, symbols);
  }
}