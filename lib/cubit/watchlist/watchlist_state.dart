part of 'watchlist_cubit.dart';

sealed class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

final class WatchlistInitial extends WatchlistState {}

final class WatchlistLoading extends WatchlistState {}

final class WatchlistFailure extends WatchlistState {}

final class WatchlistSuccess extends WatchlistState {
  final List<StockModel> watchListItems;
  @override
  List<Object> get props => [watchListItems];
  const WatchlistSuccess({required this.watchListItems});
}
