import 'package:app/features/stocks/presentation/screens/stock_screen.dart';
import 'package:app/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'event.dart';
part 'state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository _repository;

  StockBloc(this._repository) : super(StockInitial()) {
    on<SaveStockEvent>(_onSaveStock);
    on<LoadStocksEvent>(_onLoadStocks);
  }

  Future<void> _onSaveStock(
      SaveStockEvent event, Emitter<StockState> emit) async {
    try {
      await _repository.saveStock(event.stock);
      add(LoadStocksEvent());
    } catch (e) {
      emit(StockError('Failed to save stock data'));
    }
  }

  Future<void> _onLoadStocks(
      LoadStocksEvent event, Emitter<StockState> emit) async {
    try {
      emit(StockLoading());
      final stocks = await _repository.getAllStocks();
      emit(StockLoaded(stocks));
    } catch (e) {
      emit(StockError('Failed to load stocks'));
    }
  }

  Future<void> _onDeleteStock(
      DeleteStockEvent event, Emitter<StockState> emit) async {
    try {
      emit(StockLoading());
      await _repository.deleteStock(event.stock.symbol);
      final stocks = await _repository.getAllStocks();
      // final stocks = await _repository.getStocks(); // Reload remaining stocks
      emit(StockLoaded(stocks));
    } catch (e) {
      emit(StockError('Failed to delete stock: ${e.toString()}'));
    }
  }
}
