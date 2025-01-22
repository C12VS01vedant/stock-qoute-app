
part of 'bloc.dart';

abstract class StocksEvent extends Equatable {
  const StocksEvent();

  @override
  List<Object?> get props => [];
}

class FetchDefaultStocksEvent extends StocksEvent {
  final String apiKey;
  final String symbols;

  const FetchDefaultStocksEvent(this.apiKey, this.symbols);

  @override
  List<Object?> get props => [apiKey, symbols];
}

class SearchStockBySymbolEvent extends StocksEvent {
  final String apiKey;
  final String symbol;

  const SearchStockBySymbolEvent(this.apiKey, this.symbol);

  @override
  List<Object?> get props => [apiKey, symbol];
}
