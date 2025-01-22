// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockModel _$StockModelFromJson(Map<String, dynamic> json) => StockModel(
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String?,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      changeAmount: (json['changeAmount'] as num).toDouble(),
      changePercentage: (json['changePercentage'] as num).toDouble(),
    );

Map<String, dynamic> _$StockModelToJson(StockModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'currentPrice': instance.currentPrice,
      'changeAmount': instance.changeAmount,
      'changePercentage': instance.changePercentage,
    };
