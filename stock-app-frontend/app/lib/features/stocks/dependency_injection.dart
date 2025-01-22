import 'package:app/core/dependency_injection/service_locator.dart';
import 'package:app/features/stocks/data/data_sources/stocks_remote_data_source.dart';
import 'package:app/features/stocks/data/repositories/stock_repository_impl.dart';
import 'package:app/features/stocks/domain/repositories/stock_repository.dart';
import 'package:app/features/stocks/domain/usecases/get_default_stocks.dart';
import 'package:app/features/stocks/domain/usecases/search_stock_by_symbol.dart';
import 'package:app/features/stocks/presentation/bloc/bloc.dart';

import 'package:dio/dio.dart';

void stockModule(){
  sl.registerLazySingleton<StocksRemoteDataSource>(
      () => StocksRemoteDataSource(sl<Dio>()));

  // Repository
  sl.registerLazySingleton<StocksRepository>(
      () => StocksRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetDefaultStocks(sl()));
  sl.registerLazySingleton(() => SearchStockBySymbol(sl()));

  // Bloc
  sl.registerFactory(() => StocksBloc(
        getDefaultStocks: sl(),
        searchStockBySymbol: sl(),
      ));

}