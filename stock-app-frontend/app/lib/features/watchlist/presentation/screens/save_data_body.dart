import 'package:app/core/constant/app_strings.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:app/core/utils/widgets/Appbar/custom_app_bar.dart';
import 'package:app/core/utils/widgets/cards/custom_card.dart';
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
        title: 'offline data',
        backgroundColor: AppColors().primaryColor,
        foregroundColor: AppColors().backgroundColor,
        enableLogout: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StockCard(
                  symbol: 'MSFT',
                  companyName: 'XNAS',
                  currentPrice: 428.50,
                  changeAmount: -1.54,
                  changePercentage: -0.36),

                  StockCard(
                  symbol: 'TSLA',
                  companyName: 'XNAS',
                  currentPrice: 424.07,
                  changeAmount: -8.57,
                  changePercentage: -1.98)
            ],
          ),
        ),
      ),

      // body: BlocBuilder<StockBloc, StockState>(
      //   builder: (context, state) {
      //     if (state is StockLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is StockLoaded) {
      //       return StockCard(
      //           symbol: "MSFT",
      //           companyName: "XNAS",
      //           currentPrice: 428.50,
      //           changeAmount: -1.54,
      //           changePercentage: -0.36);
      //       // final stocks = state.stocks;
      //       // return ListView.builder(
      //       //   padding: const EdgeInsets.all(16),
      //       //   itemCount: stocks.length,
      //       //   itemBuilder: (context, index) {
      //       //     final stock = stocks[index];
      //       //     return StockCard(
      //       //       symbol: stock.symbol,
      //       //       companyName: stock.companyName ?? 'N/A',
      //       //       currentPrice: stock.currentPrice,
      //       //       changeAmount: stock.changeAmount,
      //       //       changePercentage: stock.changePercentage,
      //       //       onDelete: () {
      //       //         context.read<StockBloc>().add(DeleteStockEvent(stock));
      //       //       },
      //       //     );
      //       //   },
      //       // );
      //     } else if (state is StockError) {
      //       return Center(child: Text(state.message));
      //     } else {
      //       return const Center(child: Text('No data available.'));
      //     }
      //   },
      // ),
    );
  }
}
