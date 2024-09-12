import 'package:hive/hive.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/utils/constants/strings.dart';
import 'package:stock_watchlist/utils/exceptions/main_exception.dart';

class HiveServices {
  final Box<StockModel> _box;

  HiveServices() : _box = Hive.box<StockModel>(hiveBox);

  Future<void> addStock(StockModel stock) async {
    try {
      final stockExists = _box.values.any((s) => s.symbol == stock.symbol);

      if (!stockExists) {
        await _box.add(stock);
      } else {
        throw MainException('This item is already in the wishlist');
      }
    } catch (e) {
      throw MainException(
          e is MainException ? e.message : 'Failed to add stock: $e');
    }
  }

  Future<List<StockModel>> getWatchlist() async {
    try {
      final stocks = _box.values.toList();
      return stocks;
    } catch (e) {
      throw MainException('Failed to retrieve watchlist: $e');
    }
  }

  Future<void> removeStock(int key) async {
    try {
      await _box.delete(key);
    } catch (e) {
      throw MainException('Failed to remove stock: ');
    }
  }
}
