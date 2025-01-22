import 'dart:convert';
import 'package:app/core/constant/enums/button_type.dart';
import 'package:app/core/constant/icons/app_icons_path.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:app/core/utils/themes/fonts/app_typography.dart';
import 'package:app/core/utils/widgets/Appbar/custom_app_bar.dart';
import 'package:app/core/utils/widgets/Icons/custom_icon.dart';
import 'package:app/core/utils/widgets/buttons/custom_floating_button.dart';
import 'package:app/core/utils/widgets/buttons/custom_icon_button.dart';
import 'package:app/features/watchlist/presentation/bloc/bloc.dart';
import 'package:app/features/watchlist/presentation/screens/save_data_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockHomePage extends StatefulWidget {
  @override
  _StockHomePageState createState() => _StockHomePageState();
}

class _StockHomePageState extends State<StockHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _stockSymbol = '';
  Stock? _stockData;
  bool _isLoading = false;
  String _errorMessage = '';
  StockOffline? stock;

  final String _apiKey = '1dab9e2bfab83037e33555ebab3edd0a';
  final String _baseUrl = 'https://api.marketstack.com/v1'; // Changed to HTTPS

  Future<void> _fetchStockData(String symbol) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _stockData = null; // Reset stock data
    });

    try {
      final queryParameters = {
        'access_key': _apiKey,
        'symbols': symbol.toUpperCase(), // Ensure symbol is uppercase
        'limit': '1', // Limit to latest data
      };

      final uri = Uri.https('api.marketstack.com', '/v1/eod', queryParameters);

      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'].isNotEmpty) {
          setState(() {
            _stockData = Stock.fromJson(data['data'][0]);
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'No data available for this stock symbol';
            _isLoading = false;
          });
        }
      } else {
        final errorData = json.decode(response.body);
        setState(() {
          _errorMessage =
              errorData['error']?['message'] ?? 'Failed to fetch stock data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error: Please check your internet connection';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      floatingActionButton: CustomFloatingButton(
        icon: CustomIcon(
          svgPath: AppIcons.dataIcon,
          size: 34,
          color: AppColors().backgroundColor,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SaveDataScreen()),
          );
          // context.read<StockBloc>().add(LoadStocksEvent());
        },
        backgroundColor: AppColors().primaryColor,
      ),
      appBar: CustomAppBar(
        title: 'Stock Market',
        backgroundColor: AppColors().primaryColor,
        foregroundColor: AppColors().backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 8.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Enter a stock symbol to get started',
                style: AppTypography.subtitle.copyWith(
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter Stock Symbol (e.g., AAPL)',
                    labelStyle: AppTypography.label,
                    filled: true,
                    fillColor: Colors.white,
                    // prefixIcon: Icon(Icons.search, color: AppColors().primaryColor),
                    suffixIcon: IconButton(
                      icon: CustomIcon(
                        svgPath: AppIcons.searchIcon,
                        size: 34,
                        color:
                            _isLoading ? AppColors().primaryColor : Colors.grey,
                      ),
                      onPressed: () {
                        _stockSymbol = _controller.text;
                        if (_stockSymbol.isNotEmpty) {
                          _fetchStockData(_stockSymbol);
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: AppColors().primaryColor,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: AppColors().primaryColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors().primaryColor),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Fetching stock data...',
                        style: AppTypography.subtitle,
                      ),
                    ],
                  ),
                ),
              if (_errorMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          color: Colors.red[700], size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_stockData != null)
                AnimatedOpacity(
                  opacity: _stockData != null ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: _buildStockCard(_stockData!),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockCard(Stock stock) {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors().primaryColor.withOpacity(0.1),
                  AppColors().backgroundColor,
                ],
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: stock.symbol,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors().primaryColor,
                              Colors.deepPurple,
                            ],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Text(
                            stock.symbol[0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors().primaryColor,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stock.symbol,
                            style: AppTypography.heading.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            stock.companyName ?? 'N/A',
                            style: AppTypography.subtitle.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Price',
                            style: AppTypography.label,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${stock.currentPrice.toStringAsFixed(2)}',
                            style: AppTypography.heading.copyWith(
                              color: AppColors().primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Change',
                            style: AppTypography.label,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                stock.changeAmount >= 0
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: stock.changeAmount >= 0
                                    ? Colors.green
                                    : Colors.red,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${stock.changeAmount.toStringAsFixed(2)} (${stock.changePercentage.toStringAsFixed(2)}%)',
                                style: AppTypography.subtitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: stock.changeAmount >= 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: CustomIconButton(
              icon: AppIcons.saveIcon,
              type: ButtonType.secondary,
              onPressed: () {
                context.read<StockBloc>().add(SaveStockEvent(StockOffline(
                      symbol: stock.symbol,
                      companyName: stock.companyName,
                      currentPrice: stock.currentPrice,
                      changeAmount: stock.changeAmount,
                      changePercentage: stock.changePercentage,
                    )));
              },
            ),
          ),
        ],
      ),
    );
  }
}

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

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'],
      companyName: json['exchange'] ?? 'N/A',
      currentPrice: json['close'],
      changeAmount: roundToTwoDecimal(json['close'] - json['open']),
      changePercentage: roundToTwoDecimal(
          ((json['close'] - json['open']) / json['open']) * 100),
    );
  }

  static double roundToTwoDecimal(double value) {
    return (value * 100).roundToDouble() / 100;
  }
}

class StockOffline {
  final String symbol;
  final String? companyName;
  final double currentPrice;
  final double changeAmount;
  final double changePercentage;

  StockOffline({
    required this.symbol,
    this.companyName,
    required this.currentPrice,
    required this.changeAmount,
    required this.changePercentage,
  });

  factory StockOffline.fromJson(Map<String, dynamic> json) {
    return StockOffline(
      symbol: json['symbol'],
      companyName: json['name'] ?? 'N/A',
      currentPrice: json['close'],
      changeAmount: roundToTwoDecimal(json['close'] - json['open']),
      changePercentage: roundToTwoDecimal(
          ((json['close'] - json['open']) / json['open']) * 100),
    );
  }

  static double roundToTwoDecimal(double value) {
    return (value * 100).roundToDouble() / 100;
  }
}
