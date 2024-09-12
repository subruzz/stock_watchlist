part of 'search_stock_cubit.dart';

sealed class SearchStockState extends Equatable {
  const SearchStockState();

  @override
  List<Object> get props => [];
}

final class SearchStockInitial extends SearchStockState {}

final class SearchStockLoading extends SearchStockState {}

final class SearchStockFailure extends SearchStockState {
  final String message;
  @override
  List<Object> get props => [message];
  const SearchStockFailure({required this.message});
}

final class SearchStockSuccess extends SearchStockState {
  final List<StockModel> searchedStocks;
  @override
  List<Object> get props => [searchedStocks];
  const SearchStockSuccess({required this.searchedStocks});
}
