import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stock_watchlist/cubit/home/search_stock_cubit.dart';
import 'package:stock_watchlist/cubit/watchlist/watchlist_cubit.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/services/alpha_vantage_service.dart';
import 'package:stock_watchlist/services/hive_services.dart';
import 'package:stock_watchlist/views/screens/splash_screen.dart';
import 'package:stock_watchlist/views/widgets/common_widgets/messenger.dart';
import 'package:stock_watchlist/utils/constants/strings.dart';
import 'package:stock_watchlist/utils/constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(StockModelAdapter());
  await Hive.openBox<StockModel>(hiveBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchStockCubit(
            StockService(),
          ),
        ),
        BlocProvider(
          create: (context) => WatchlistCubit(
            HiveServices(),
          )..getWatchListItems(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        scaffoldMessengerKey: Messenger.scaffoldKey,
        home: const SplashScreen(),
      ),
    );
  }
}
