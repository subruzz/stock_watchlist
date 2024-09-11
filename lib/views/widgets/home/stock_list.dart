import 'package:flutter/material.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';

class StockListPage extends StatelessWidget {
  final List<Map<String, dynamic>> stocks;

  StockListPage({required this.stocks});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];
          return Card(
            color: kMainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 8.0,
            child: ListTile(
              title: Text(stock['symbol'], style: kBodyTextStyle),
              subtitle: Text(
                  'Price: \$${stock['sharePrice'].toStringAsFixed(2)}',
                  style: kBodyTextStyle),
              trailing: IconButton(
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 28.0,
                ),
                onPressed: () {
                  // Handle add to watchlist
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
