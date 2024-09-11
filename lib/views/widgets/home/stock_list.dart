import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_watchlist/cubit/home/search_stock_cubit.dart';
import 'package:stock_watchlist/cubit/watchlist/watchlist_cubit.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import '../common_widgets/dialog.dart';
import '../common_widgets/messenger.dart';

class StockListPage extends StatelessWidget {
  const StockListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchStockCubit, SearchStockState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SearchStockLoading) {
          return _buildShimmerListTile();
        }
        if (state is SearchStockSuccess) {
          return state.searchedStocks.isEmpty
              ? _buildEmptyState()
              : _buildStockList(context, state);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildEmptyState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Search for stocks',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockList(BuildContext context, SearchStockSuccess state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.searchedStocks.length,
        itemBuilder: (context, index) {
          final stock = state.searchedStocks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildStockCard(context, stock),
          );
        },
      ),
    );
  }

  Widget _buildStockCard(BuildContext context, dynamic stock) {
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
          trailing: _buildAddToWatchlistButton(context, stock),
        ),
      ),
    );
  }

  Widget _buildAddToWatchlistButton(BuildContext context, dynamic stock) {
    return BlocListener<WatchlistCubit, WatchlistState>(
        listener: (context, state) {
          if (state.message != null) {
            Messenger.showSnackBar(message: state.message!);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.add, color: Colors.blue, size: 24),
            onPressed: () => _showAddToWatchlistDialog(context, stock),
            tooltip: 'Add to Watchlist',
          ),
        ));
  }

  void _showAddToWatchlistDialog(BuildContext context, StockModel stock) {
    showCustomDialog(
      context,
      'Add to Watchlist',
      'Add',
      'Do you want to add this to your watchlist?',
      () => context.read<WatchlistCubit>().addToWatchlist(stock),
    );
  }

  Widget _buildShimmerListTile() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Shimmer.fromColors(
              baseColor: Colors.blue.shade100,
              highlightColor: Colors.blue.shade50,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade800, Colors.blue.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
