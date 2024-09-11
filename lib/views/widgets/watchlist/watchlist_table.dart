import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/cubit/watchlist/watchlist_cubit.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/views/widgets/watchlist/watchlist_table_shimmer.dart'; // Ensure you have your StockModel defined

class WatchlistTable extends StatelessWidget {
  const WatchlistTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistCubit, WatchlistState>(
      builder: (context, state) {
        if (state is WatchlistLoading) {
          return const WatchlistTableShimmer();
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Table(
              border: const TableBorder(
                top: BorderSide.none,
                bottom: BorderSide.none,
                left: BorderSide.none,
                right: BorderSide.none,
                verticalInside: BorderSide(color: Colors.black),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1.5),
                1: FlexColumnWidth(1),
                2: FixedColumnWidth(50),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  children: [
                    _buildHeaderCell('Watchlist'),
                    _buildHeaderCell('Share Price'),
                    _buildHeaderCell(''),
                  ],
                ),
                // Display rows based on the state
                if (state is WatchlistSuccess)
                  ...state.watchListItems.map((item) => _buildTableRow(item))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCell(String text) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.all(17.0),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  TableRow _buildTableRow(StockModel stock) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(stock.companyName ?? ''),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(stock.sharePrice
                .toString()), // Ensure you have a 'stoploss' field or adjust accordingly
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.close, size: 18),
              onPressed: () {
                // Handle the remove action
                // Example: BlocProvider.of<WatchlistCubit>(context).removeStock(stock);
              },
            ),
          ),
        ),
      ],
    );
  }
}
