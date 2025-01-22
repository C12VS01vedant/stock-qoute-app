import 'package:app/features/watchlist/presentation/bloc/bloc.dart';
import 'package:app/features/watchlist/presentation/screens/save_data_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SaveDataScreen extends StatelessWidget {
  const SaveDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<StockBloc>(),
      child: const SavedDataPage(),
    );
  }
}
