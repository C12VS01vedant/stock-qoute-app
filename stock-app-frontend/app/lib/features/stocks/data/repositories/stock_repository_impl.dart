import 'package:app/features/stocks/domain/repositories/stock_repository.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/stock.dart';

import '../data_sources/stocks_remote_data_source.dart';


class StocksRepositoryImpl implements StocksRepository {
  final StocksRemoteDataSource remoteDataSource;

  StocksRepositoryImpl(this.remoteDataSource);

  @override
 Future<Either<String, List<Stock>>> getDefaultStocks(String apiKey, String symbols) async {
    try {
      final response = await remoteDataSource.getDefaultStocks(apiKey, symbols);
      print('Response type: ${response.runtimeType}');
      print('Response: $response');
      
      final models = await remoteDataSource.getDefaultStocks(apiKey, symbols);
      return Right(models.map((model) => model.toDomain()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Stock>> searchStockBySymbol(String apiKey, String symbol) async {
    try {
      final model = await remoteDataSource.searchStockBySymbol(apiKey, symbol);
      if (model != null) {
        return Right(model.toDomain());
      }
      return const Left("Stock not found");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
