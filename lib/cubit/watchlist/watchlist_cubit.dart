// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/services/hive_services.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final HiveServices hiveServices;
  WatchlistCubit(
    this.hiveServices,
  ) : super(WatchlistInitial());
  void getWatchListItems() async {
    emit(WatchlistLoading());
    try {
      final res = await hiveServices.getWatchlist();
      emit(WatchlistSuccess(watchListItems: res));
    } catch (e) {
      emit(WatchlistFailure());
    }
  }
}
