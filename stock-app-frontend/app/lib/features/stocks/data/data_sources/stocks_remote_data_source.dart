import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/stock_model.dart';

part 'stocks_remote_data_source.g.dart';

const String API_KEY = "1dab9e2bfab83037e33555ebab3edd0a";

@RestApi(baseUrl: "http://api.marketstack.com/v1")
abstract class StocksRemoteDataSource {
  factory StocksRemoteDataSource(Dio dio) = _StocksRemoteDataSource;

  @GET("/eod")
  Future<List<StockModel>> getDefaultStocks(
    @Query("access_key") String apiKey,
    @Query("symbols") String symbols,
  );

  @GET("/eod")

  Future<StockModel?> searchStockBySymbol(
    @Query("access_key") String apiKey,
    @Query("symbols") String symbol,
  );
}

