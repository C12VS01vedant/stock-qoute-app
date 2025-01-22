import 'package:app/features/stocks/domain/entities/stock.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_model.g.dart';

@JsonSerializable()
class StockModel {
  final String symbol;
  final String? companyName;
  final double currentPrice;
  final double changeAmount;
  final double changePercentage;

  StockModel({
    required this.symbol,
    this.companyName,
    required this.currentPrice,
    required this.changeAmount,
    required this.changePercentage,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'] ?? '', // Default to empty string if null
      companyName: json['companyName'] as String?,
      currentPrice: (json['currentPrice'] ?? 0.0) as double, // Default to 0.0
      changeAmount: (json['changeAmount'] ?? 0.0) as double,
      changePercentage: (json['changePercentage'] ?? 0.0) as double,
    );
  }

  Map<String, dynamic> toJson() => _$StockModelToJson(this);

  Stock toDomain() {
    return Stock(
      symbol: symbol,
      companyName: companyName,
      currentPrice: currentPrice,
      changeAmount: changeAmount,
      changePercentage: changePercentage,
    );
  }
}

