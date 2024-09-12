import 'package:flutter/material.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';

class SearchListMsg extends StatelessWidget {
  final String imagePath;
  final String message;

  const SearchListMsg({
    super.key,
    required this.imagePath,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: kBodyTextStyle.copyWith(color: kBlack),
            ),
          ],
        ),
      ),
    );
  }
}
