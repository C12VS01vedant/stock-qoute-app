class Stock {
  final String symbol;
  final String? companyName;
  final double currentPrice;
  final double changeAmount;
  final double changePercentage;

  Stock({
    required this.symbol,
    this.companyName,
    required this.currentPrice,
    required this.changeAmount,
    required this.changePercentage,
  });
}
