part of 'bloc.dart';

abstract class StocksState extends Equatable {
  const StocksState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class StocksInitial extends StocksState {}

/// Loading state
class StocksLoading extends StocksState {}

/// Loaded state for default stocks
class DefaultStocksLoaded extends StocksState {
  final List<Stock> stocks;

  const DefaultStocksLoaded(this.stocks);

  @override
  List<Object?> get props => [stocks];
}

/// Loaded state for searched stock
class SearchedStockLoaded extends StocksState {
  final Stock stock;

  const SearchedStockLoaded(this.stock);

  @override
  List<Object?> get props => [stock];
}

/// Error state
class StocksError extends StocksState {
  final String message;

  const StocksError(this.message);

  @override
  List<Object?> get props => [message];
}
