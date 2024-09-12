import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/cubit/watchlist/watchlist_cubit.dart';
import 'package:stock_watchlist/cubit/watchlist/watchlist_state.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/views/widgets/common_widgets/dialog.dart';
import 'package:stock_watchlist/views/widgets/common_widgets/messenger.dart';
import 'package:stock_watchlist/views/widgets/watchlist/empty_wishlist_msg.dart';
import 'package:stock_watchlist/views/widgets/watchlist/watchlist_table_shimmer.dart';

class WatchlistTable extends StatelessWidget {
  const WatchlistTable({super.key});

  @override
  Widget build(BuildContext context) {
    log('state is ${context.read<WatchlistCubit>().state}');
    return BlocConsumer<WatchlistCubit, WatchlistState>(
      listener: (context, state) {
        if (state is WatchlistActionSuccess) {
          Messenger.showSnackBar(message: state.message);
        }
        if (state is WatchlistError) {
          Messenger.showSnackBar(message: state.message);
        }
      },
      buildWhen: (previous, current) =>
          current is WatchlistInitLoading || current is WatchlistLoaded,
      builder: (context, state) {
        if (state is WatchlistLoading) {
          return const WatchlistTableShimmer();
        }

        if (state is WatchlistLoaded && state.watchListItems.isEmpty) {
          return const EmptyWishlistMsg();
        }

        if (state is WatchlistLoaded) {
          return _buildWatchlistTable(context, state.watchListItems);
        }

        return const SizedBox(); 
      },
    );
  }

  Widget _buildWatchlistTable(BuildContext context, List<StockModel> items) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Table(
            border: TableBorder(
              top: BorderSide.none,
              bottom: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
              verticalInside: BorderSide(color: Colors.blue.shade200),
            ),
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(1),
              2: FixedColumnWidth(50),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              _buildHeaderRow(),
              ...items.map((item) => _buildTableRow(item, context)),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border(bottom: BorderSide(color: Colors.blue.shade200)),
      ),
      children: [
        _buildHeaderCell('Watchlist'),
        _buildHeaderCell('Share Price'),
        _buildHeaderCell(''),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(StockModel stock, BuildContext context) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              stock.companyName ?? '',
              style: TextStyle(color: Colors.blue.shade800),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              stock.sharePrice?.toString() ?? 'N/A',
              style: TextStyle(color: Colors.blue.shade600),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.close, size: 18, color: Colors.red.shade400),
              onPressed: () {
                showCustomDialog(
                  context,
                  'Are you sure',
                  'Remove',
                  'Do you want to remove this item from the watchlist?',
                  () {
                    context
                        .read<WatchlistCubit>()
                        .removeFromWatchlist(stock.key ?? 0);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
