import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/views/widgets/common_widgets/messenger.dart';
import 'package:stock_watchlist/utils/constants/strings.dart';
import 'package:stock_watchlist/utils/constants/theme.dart';
import 'package:stock_watchlist/views/screens/main_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      scaffoldMessengerKey: Messenger.scaffoldKey,
      home: const MainScreen(),
    );
  }
}
