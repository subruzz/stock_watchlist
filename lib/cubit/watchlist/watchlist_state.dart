import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/services/hive_services.dart';
import '../../utils/exceptions/main_exception.dart';

// Base state
abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

// Initial state
class WatchlistInitial extends WatchlistState {}

// Loading state
class WatchlistLoading extends WatchlistState {}

class WatchlistInitLoading extends WatchlistState {}

// Loaded state
class WatchlistLoaded extends WatchlistState {
  final List<StockModel> watchListItems;

  const WatchlistLoaded(this.watchListItems);

  @override
  List<Object?> get props => [watchListItems];
}

// Error state
class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}

// Action success state
class WatchlistActionSuccess extends WatchlistState {
  final String message;

  const WatchlistActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
