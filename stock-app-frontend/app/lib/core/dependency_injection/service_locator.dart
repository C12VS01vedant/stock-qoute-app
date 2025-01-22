import 'package:app/core/network/local/offline_repository.dart';
import 'package:app/features/authentication/dependency_injection.dart';
import 'package:app/features/stocks/dependency_injection.dart';
import 'package:app/features/stocks/presentation/screens/stock_screen.dart';
import 'package:app/features/watchlist/dependency_injection.dart';



import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register Dio
  sl.registerLazySingleton(() {
    final dio = Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:5000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      contentType: 'application/json',
    ));

    // Add logging interceptor for debugging
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  });

  // register hive
   sl.registerLazySingleton(() => HiveDatabaseService<StockOffline>());

  // modules
  authModule();
  stockModule();
  watchlistModule();


}
