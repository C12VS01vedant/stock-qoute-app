import 'package:app/core/constant/app_strings.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:app/core/utils/widgets/Appbar/custom_app_bar.dart';
import 'package:app/features/watchlist/presentation/bloc/bloc.dart';
import 'package:app/features/watchlist/presentation/widgets/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedDataPage extends StatelessWidget {
  const SavedDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.appName,
        backgroundColor: AppColors().primaryColor,
        foregroundColor: AppColors().backgroundColor,
        enableLogout: false,
      ),
      body: BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          if (state is StockLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StockLoaded) {
            final stocks = state.stocks;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];
                return StockCard(
                  symbol: stock.symbol,
                  companyName: stock.companyName ?? 'N/A',
                  currentPrice: stock.currentPrice,
                  changeAmount: stock.changeAmount,
                  changePercentage: stock.changePercentage,
                  onDelete: () {
                    context.read<StockBloc>().add(DeleteStockEvent(stock));
                  },
                );
              },
            );
          } else if (state is StockError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
