import 'package:flutter/material.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';

void showCustomDialog(BuildContext context, String title, String buttonText,
    String subTitle, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(subTitle),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: kBodyTextStyle,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              onConfirm();
            },
            child: Text(
              buttonText,
              style: kBodyTextStyle.copyWith(color: kWhite),
            ),
          ),
        ],
      );
    },
  );
}
