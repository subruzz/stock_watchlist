import 'package:equatable/equatable.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/utils/config/debouncer.dart';
import '../../services/alpha_vantage_service.dart';
import '../../utils/exceptions/main_exception.dart';

part 'search_stock_state.dart';

class SearchStockCubit extends Cubit<SearchStockState> {
  final StockService _stockService;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 700));
  SearchStockCubit(this._stockService)
      : super(
          const SearchStockSuccess(searchedStocks: []),
        );

  Future<void> searchStocks(String query) async {
    if (query.isEmpty) {
      return emit(const SearchStockSuccess(searchedStocks: []));
    }
    emit(SearchStockLoading());
    _debouncer.run(() async {
      try {
        final stocks = await _stockService.searchStocks(query);
        emit(SearchStockSuccess(searchedStocks: stocks));
      } catch (e) {
        if (e is MainException) {
          emit(SearchStockFailure(message: e.message));
        } else {
          emit(const SearchStockFailure(message: 'An unknown error occurred.'));
        }
      }
    });
  }
}
