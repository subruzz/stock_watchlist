import 'package:flutter/material.dart';

class WatchlistTable extends StatelessWidget {
  const WatchlistTable({Key? key}) : super(key: key);

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
                _buildHeaderCell('Watchlist'),
                _buildHeaderCell('Shortlist'),
                _buildHeaderCell(''),
              ],
            ),
            _buildTableRow('Company', 'Stoploss'),
            _buildTableRow('TATAmotors', '350'),
            _buildTableRow('HDFC', '2030'),
            _buildTableRow('ITC', '215'),
            _buildTableRow('AsianPaint', '1500'),
          ],
        ),
      ),
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

  TableRow _buildTableRow(String company, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(company),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(value),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.close, size: 18),
          ),
        ),
      ],
    );
  }
}
