import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/cubit/home/search_stock_cubit.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';
import 'package:stock_watchlist/views/widgets/home/search_field.dart';
import 'package:stock_watchlist/views/widgets/home/stock_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<bool> _isSearchEmpty = ValueNotifier(true);
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search bar
          SearchTextField(
              isSearchEmpty: _isSearchEmpty,
              searchController: _searchController,
              onSearchChanged: (value) {
                _isSearchEmpty.value = value.isEmpty;
                context.read<SearchStockCubit>().searchStocks(value.trim());
              }),
          kSizedBoxHeight15,
          // Loading indicator
          // Stock list
          const StockListPage()
        ],
      ),
    );
  }
}
