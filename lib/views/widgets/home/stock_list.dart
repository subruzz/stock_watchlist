import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_watchlist/cubit/home/search_stock_cubit.dart';
import 'package:stock_watchlist/services/hive_services.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';

import '../common_widgets/dialog.dart';

class StockListPage extends StatelessWidget {
  const StockListPage({
    super.key,
  });

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
              ? const Expanded(
                  child: Center(
                    child: Text('Search for stocks'),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: state.searchedStocks.length,
                    itemBuilder: (context, index) {
                      final stock = state.searchedStocks[index];
                      return Card(
                        color: kMainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 8.0,
                        child: ListTile(
                          title: Text(stock.companyName ?? '',
                              style: kBodyTextStyle),
                          subtitle: Text(
                              'Price: \$${stock.sharePrice!.toStringAsFixed(2)}',
                              style: kBodyTextStyle),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 28.0,
                            ),
                            onPressed: () {
                              showCustomDialog(
                                  context,
                                  'Add to Watchlist',
                                  'Add',
                                  'Do you want to add this to your watchlist?',
                                  () {
                                HiveServices().addStock(stock);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
        }
        return SizedBox();
      },
    );
  }

  Widget _buildShimmerListTile() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10, // Placeholder item count
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 8.0,
              child: SizedBox(
                height: 80, // Set the desired height for each card
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 20,
                        width: double.infinity,
                        color: Colors.grey[300], // Placeholder for title
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.grey[300], // Placeholder for subtitle
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
