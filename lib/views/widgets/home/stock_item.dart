import 'package:flutter/material.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/views/widgets/home/add_to_watchlist_button.dart';

class StockItem extends StatelessWidget {
  const StockItem({super.key, required this.stock});
  final StockModel stock;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              stock.companyName ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Price: \$${stock.sharePrice!.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            trailing: AddToWatchlistButton(stock: stock)),
      ),
    );
  }
}
