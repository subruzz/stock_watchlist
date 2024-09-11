import 'package:flutter/material.dart';
import 'dart:async';
import 'package:stock_watchlist/utils/constants/app_assets.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';
import 'package:stock_watchlist/views/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Center(
        child: Image.asset(
          logo,
          width: 150,
        ),
      ),
    );
  }
}
