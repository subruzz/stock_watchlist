import 'package:flutter/material.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/views/widgets/home/stock_item.dart';

class HomeSearchList extends StatelessWidget {
  const HomeSearchList({super.key, required this.searchedStocks});
  final List<StockModel> searchedStocks;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: searchedStocks.length,
        itemBuilder: (context, index) {
          final stock = searchedStocks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: StockItem(stock: stock),
          );
        },
      ),
    );
  }
}
