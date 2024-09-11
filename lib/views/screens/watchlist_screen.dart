import 'package:flutter/material.dart';
import 'package:stock_watchlist/views/widgets/watchlist/watchlist_table.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(13),
      child: WatchlistTable(),
    );
  }
}
