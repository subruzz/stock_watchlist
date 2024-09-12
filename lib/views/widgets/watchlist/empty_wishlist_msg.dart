import 'package:flutter/material.dart';

class EmptyWishlistMsg extends StatelessWidget {
  const EmptyWishlistMsg({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No items in your watchlist',
        style: TextStyle(
          color: Colors.blue.shade700,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
