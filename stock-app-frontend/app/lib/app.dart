import 'package:app/features/authentication/presentation/screens/auth_screen.dart';
import 'package:app/features/stocks/domain/usecases/get_default_stocks.dart';
import 'package:app/features/stocks/domain/usecases/search_stock_by_symbol.dart';
import 'package:app/features/stocks/presentation/bloc/bloc.dart';
import 'package:provider/provider.dart';
import 'package:app/core/dependency_injection/service_locator.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add StocksBloc here to be available globally
        BlocProvider(
          create: (context) => StocksBloc(
            getDefaultStocks:
                di.sl<GetDefaultStocks>(), // Get dependencies from DI
            searchStockBySymbol:
                di.sl<SearchStockBySymbol>(), // Get dependencies from DI
          ),
        ),
      ],
      child: MaterialApp(
        title: 'stock',
        locale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthScreen(),
      ),
    );
  }
}
