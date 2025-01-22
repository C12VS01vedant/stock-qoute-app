import 'package:app/core/dependency_injection/service_locator.dart';
import 'package:app/core/network/local/offline_repository.dart';
import 'package:app/features/stocks/presentation/screens/stock_screen.dart';
import 'package:app/features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:app/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:app/features/watchlist/presentation/bloc/bloc.dart';

void watchlistModule() {
  sl.registerLazySingleton<StockRepository>(
    () => StockRepositoryImpl(sl<HiveDatabaseService<StockOffline>>()),
  );

  sl.registerFactory(() => StockBloc(sl<StockRepository>()));
}
