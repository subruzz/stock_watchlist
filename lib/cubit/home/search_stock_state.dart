part of 'search_stock_cubit.dart';

sealed class SearchStockState extends Equatable {
  const SearchStockState();

  @override
  List<Object> get props => [];
}


final class SearchStockLoading extends SearchStockState {}

final class SearchStockFailure extends SearchStockState {
  final String message;

  const SearchStockFailure({required this.message});
}

final class SearchStockSuccess extends SearchStockState {
  final List<StockModel> searchedStocks;

  const SearchStockSuccess({required this.searchedStocks});
}
