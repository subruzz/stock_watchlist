import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/cubit/home/search_stock_cubit.dart';
import 'package:stock_watchlist/utils/constants/app_assets.dart';
import 'package:stock_watchlist/views/widgets/common_widgets/messenger.dart';
import 'package:stock_watchlist/views/widgets/home/home_empty_list_msg.dart';
import 'package:stock_watchlist/views/widgets/home/home_search_item_shimmer.dart';
import 'package:stock_watchlist/views/widgets/home/home_search_list.dart';
import 'package:stock_watchlist/views/widgets/home/search_list_msg.dart';

class StockListPage extends StatelessWidget {
  const StockListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchStockCubit, SearchStockState>(
      listener: (context, state) {
        if (state is SearchStockFailure) {
          Messenger.showSnackBar(message: state.message);
        }
      },
      builder: (context, state) {
        if (state is SearchStockLoading) {
          return const HomeSearchItemShimmer();
        }
        if (state is SearchStockFailure) {
          return SearchListMsg(
            imagePath: error,
            message: state.message,
          );
        }
        if (state is SearchStockInitial) {
          return const HomeEmptyListMsg();
        }
        if (state is SearchStockSuccess) {
          return state.searchedStocks.isEmpty
              ? const SearchListMsg(
                  imagePath: empty, message: 'No Search Result Found!')
              : HomeSearchList(searchedStocks: state.searchedStocks);
        }
        return const SizedBox();
      },
    );
  }
}
