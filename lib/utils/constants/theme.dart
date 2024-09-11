import 'package:flutter/material.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';

var theme = ThemeData(
  appBarTheme:  AppBarTheme(
    centerTitle: true,
    titleTextStyle: const TextStyle(
        color: Color.fromARGB(255, 238, 233, 233),
        fontSize: 25,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5),
    color: kMainColor,
  ),
  buttonTheme:  ButtonThemeData(
    buttonColor: kMainColor,
  ),
  textTheme: const TextTheme(),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    selectedItemColor: kMainColor,
    elevation: 2,
    unselectedItemColor: kGreyColor,
    selectedIconTheme:const  IconThemeData(size: 27),
  ),
  elevatedButtonTheme:  ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(kMainColor),
    ),
  ),
);
