part of 'bloc.dart';

abstract class StockEvent {}

class SaveStockEvent extends StockEvent {
  final StockOffline stock;

  SaveStockEvent(this.stock);
}

class DeleteStockEvent extends StockEvent {
  final StockOffline stock;

  DeleteStockEvent(this.stock);
}

class LoadStocksEvent extends StockEvent {}
