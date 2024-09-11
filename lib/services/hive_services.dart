import 'package:hive/hive.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/utils/constants/strings.dart';

class StockRepository {
  final Box<StockModel> _box;

  StockRepository() : _box = Hive.box<StockModel>(hiveBox);

  Future<void> addStock(StockModel stock) async {
    try {
      final stockExists = _box.values.any((s) => s.symbol == stock.symbol);

      if (!stockExists) {
        await _box.add(stock);
      } else {
 
      }
    } catch (e) {
      throw Exception('Failed to add stock: $e');
    }
  }

  Future<List<StockModel>> getWatchlist() async {
    try {
      final stocks = _box.values.toList();
      return stocks;
    } catch (e) {
      throw Exception('Failed to retrieve watchlist: $e');
    }
  }

  Future<void> removeStock(int index) async {
    try {
      await _box.deleteAt(index);
    } catch (e) {
      throw Exception('Failed to remove stock: $e');
    }
  }
}
