import 'package:flutter/material.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';
import 'package:stock_watchlist/views/widgets/home/search_field.dart';
import 'package:stock_watchlist/views/widgets/home/stock_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  List<Map<String, dynamic>> _stocks = [
    {'symbol': 'AAPL', 'sharePrice': 150.00},
    {'symbol': 'GOOGL', 'sharePrice': 2800.00},
    {'symbol': 'MSFT', 'sharePrice': 300.00},
  ];

  void _onSearchChanged(String query) {
    // Simulate a search with static data for now
    setState(() {
      if (query.isEmpty) {
        _stocks = [
          {'symbol': 'AAPL', 'sharePrice': 150.00},
          {'symbol': 'GOOGL', 'sharePrice': 2800.00},
          {'symbol': 'MSFT', 'sharePrice': 300.00},
        ];
      } else {
        _stocks = _stocks.where((stock) {
          return stock['symbol'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search bar
          SearchTextField(
              searchController: _searchController, onSearchChanged: (value) {}),
          kSizedBoxHeight15,
          // Loading indicator
          // Stock list
          StockListPage(stocks: _stocks)
        ],
      ),
    );
  }
}
