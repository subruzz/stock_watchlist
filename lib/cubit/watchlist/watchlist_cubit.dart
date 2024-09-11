// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/services/hive_services.dart';

import '../../utils/exceptions/main_exception.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final HiveServices hiveServices;

  WatchlistCubit(this.hiveServices) : super(const WatchlistState());

  // Fetch watchlist items
  void getWatchListItems() async {
    emit(state.copyWith(
        isLoading: true, message: null)); // Reset message and set loading
    try {
      final res = await hiveServices.getWatchlist();
      emit(state.copyWith(
          isLoading: false, watchListItems: res)); // Success case
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          hasError: true,
          message: 'Failed to load watchlist')); // Error case
    }
  }

  // Remove an item from the watchlist
  void removeFromWatchlist(int key) async {
    try {
      await hiveServices.removeStock(key);
      emit(state.copyWith(
          message:
              'Item has been removed from the watchlist')); // Success message
      getWatchListItems(); // Refresh watchlist
    } catch (e) {
      if (e is MainException) {
        emit(state.copyWith(message: e.message)); // Emit exception message
      } else {
        emit(state.copyWith(
            message: 'An unknown error occurred.')); // Default error message
      }
    }
  }

  void addToWatchlist(StockModel stock) async {
    try {
      await hiveServices.addStock(stock);
      emit(state.copyWith(
          message:
              'Item has been added to the watchlist')); // Success message
      getWatchListItems(); // Refresh watchlist
    } catch (e) {
      if (e is MainException) {
        emit(state.copyWith(message: e.message)); // Emit exception message
      } else {
        emit(state.copyWith(
            message: 'An unknown error occurred.')); // Default error message
      }
    }
  }
}
