import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/stock.dart';
import '../../domain/usecases/get_default_stocks.dart';
import '../../domain/usecases/search_stock_by_symbol.dart';

part 'event.dart';
part 'state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final GetDefaultStocks getDefaultStocks;
  final SearchStockBySymbol searchStockBySymbol;

  StocksBloc({
    required this.getDefaultStocks,
    required this.searchStockBySymbol,
  }) : super(StocksInitial()) {
    on<FetchDefaultStocksEvent>(_onFetchDefaultStocksEvent);
    on<SearchStockBySymbolEvent>(_onSearchStockBySymbolEvent);
  }

  Future<void> _onFetchDefaultStocksEvent(
      FetchDefaultStocksEvent event, Emitter<StocksState> emit) async {
    emit(StocksLoading());
    final result = await getDefaultStocks(event.apiKey, event.symbols); // Using API_KEY and symbols
    result.fold(
      (failure) => emit(StocksError(failure)),
      (stocks) => emit(DefaultStocksLoaded(stocks)),
    );
  }

  Future<void> _onSearchStockBySymbolEvent(
      SearchStockBySymbolEvent event, Emitter<StocksState> emit) async {
    emit(StocksLoading());
    final result = await searchStockBySymbol(event.apiKey, event.symbol); // Using API_KEY and symbol
    result.fold(
      (failure) => emit(StocksError(failure)),
      (stock) => emit(SearchedStockLoaded(stock)),
    );
  }
}

