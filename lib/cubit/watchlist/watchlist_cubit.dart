import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/services/hive_services.dart';
import '../../utils/exceptions/main_exception.dart';
import 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final HiveServices hiveServices;

  WatchlistCubit(this.hiveServices) : super(WatchlistInitial());

  // Fetch watchlist items
  void getWatchListItems() async {
    emit(WatchlistInitLoading());
    try {
      final res = await hiveServices.getWatchlist();
      emit(WatchlistLoaded(res));
    } catch (e) {
      emit(const WatchlistError('Failed to load watchlist'));
    }
  }

  // Remove an item from the watchlist
  void removeFromWatchlist(int key) async {
    emit(WatchlistLoading());
    try {
      await hiveServices.removeStock(key);
      emit(const WatchlistActionSuccess(
          'Item has been removed from the watchlist'));
      getWatchListItems(); // Refresh watchlist
    } catch (e) {
      if (e is MainException) {
        emit(WatchlistError(e.message));
      } else {
        emit(const WatchlistError('An unknown error occurred.'));
      }
    }
  }

  void addToWatchlist(StockModel stock) async {
    emit(WatchlistLoading());
    try {
      await hiveServices.addStock(stock);
      emit(
          const WatchlistActionSuccess('Item has been added to the watchlist'));
      getWatchListItems();
    } catch (e) {
      if (e is MainException) {
        log('main exception');
        emit(WatchlistError(e.message));
      } else {
        emit(const WatchlistError('An unknown error occurred.'));
      }
    }
  }
}
