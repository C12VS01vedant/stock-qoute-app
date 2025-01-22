import 'package:app/features/stocks/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/stock.dart';

const String API_KEY = "1dab9e2bfab83037e33555ebab3edd0a"; // Hardcoded API key

class StockDashboard extends StatefulWidget {
  const StockDashboard({Key? key}) : super(key: key);

  @override
  _StockDashboardState createState() => _StockDashboardState();
}

class _StockDashboardState extends State<StockDashboard> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the default stocks using the API key and predefined symbols
    context.read<StocksBloc>().add(
        const FetchDefaultStocksEvent(API_KEY, "AAPL,MSFT,GOOGL,AMZN,TSLA"));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by stock symbol...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<StocksBloc>().add(
                        SearchStockBySymbolEvent(
                          API_KEY,
                          value,
                        ),
                      );
                }
              },
            ),
            const SizedBox(height: 16.0),

            // Stock List
            Expanded(
              child: BlocBuilder<StocksBloc, StocksState>(
                builder: (context, state) {
                  if (state is StocksLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DefaultStocksLoaded) {
                    return _buildStockList(state.stocks);
                  } else if (state is SearchedStockLoaded) {
                    return _buildStockList([state.stock]);
                  } else if (state is StocksError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: Text("No data available"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build stock list
  Widget _buildStockList(List<Stock> stocks) {
    return ListView.separated(
      itemCount: stocks.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(stock.symbol[0]),
          ),
          title: Text(stock.symbol),
          subtitle: Text(stock.companyName?? ""),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$${stock.currentPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${stock.changeAmount.toStringAsFixed(2)} (${stock.changePercentage.toStringAsFixed(2)}%)",
                style: TextStyle(
                  color: stock.changeAmount >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
