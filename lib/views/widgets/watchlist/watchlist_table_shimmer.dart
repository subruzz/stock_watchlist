import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WatchlistTableShimmer extends StatelessWidget {
  const WatchlistTableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FixedColumnWidth(40),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black)),
              ),
              children: [
                _buildShimmerHeaderCell(),
                _buildShimmerHeaderCell(),
                _buildShimmerHeaderCell(),
              ],
            ),
            for (int i = 0; i < 5; i++) _buildShimmerTableRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerHeaderCell() {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 20,
            width: 100,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  TableRow _buildShimmerTableRow() {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 20,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 20,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Icon(Icons.close, size: 18, color: Colors.grey[300]),
            ),
          ),
        ),
      ],
    );
  }
}
