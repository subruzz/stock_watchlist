part of 'watchlist_cubit.dart';

class WatchlistState extends Equatable {
  final bool isLoading;
  final bool hasError;
  final List<StockModel> watchListItems;
  final String? message;

  const WatchlistState({
    this.isLoading = false,
    this.hasError = false,
    this.watchListItems = const [],
    this.message,
  });

  // CopyWith method for immutability
  WatchlistState copyWith({
    bool? isLoading,
    bool? hasError,
    List<StockModel>? watchListItems,
    String? message,
  }) {
    return WatchlistState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      watchListItems: watchListItems ?? this.watchListItems,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasError, watchListItems, message];
}
