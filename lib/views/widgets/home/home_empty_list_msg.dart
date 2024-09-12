import 'package:flutter/material.dart';

import '../../../utils/constants/ui_const.dart';

class HomeEmptyListMsg extends StatelessWidget {
  const HomeEmptyListMsg({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.trending_up, size: 100, color: Colors.blue.shade300),
            const SizedBox(height: 24),
            Text(
              'Discover Your Next Investment',
              style: kSubHeadingTextStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                  'Enter a company name or stock symbol to explore potential opportunities and add them to your watchlist.',
                  textAlign: TextAlign.center,
                  style: kBodyTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
