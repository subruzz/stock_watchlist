import 'package:flutter/material.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';

var theme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
        color: Color.fromARGB(255, 238, 233, 233),
        fontSize: 25,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5),
    color: kMainColor,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: kMainColor,
  ),
  textTheme: const TextTheme(),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: kMainColor,
    elevation: 2,
    unselectedItemColor: kGreyColor,
    selectedIconTheme: IconThemeData(size: 27),
  ),
);
