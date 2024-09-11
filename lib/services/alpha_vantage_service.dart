import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/utils/constants/secrets.dart';
import 'package:stock_watchlist/utils/exceptions/main_exception.dart'; // Import your exception class

class StockService {
  final Dio _dio = Dio();
  final String _apiKey = alphaVantageKey;

  Future<List<StockModel>> searchStocks(String query) async {
    log('query is $query');
    try {
      // Perform the SYMBOL_SEARCH API request
      final response = await _dio.get(
        'https://www.alphavantage.co/query',
        queryParameters: {
          'function': 'SYMBOL_SEARCH',
          'keywords': query,
          'apikey': _apiKey,
        },
      );
      log('API Response Data: ${response.data}');

      // Extract the list of best matches
      final List<dynamic>? matches = response.data['bestMatches'];
      log('our matches is _> $matches');
      if (matches == null || matches.isEmpty) {
        throw MainException('No matches found in the response data');
      }

      final List<StockModel> stocks = [];

      for (var match in matches) {
        final symbol = match['1. symbol'] as String;
        final String? symbolCompanyName = match['2. name'];

        // Fetch the latest price for the stock symbol
        final priceResponse = await _dio.get(
          'https://www.alphavantage.co/query',
          queryParameters: {
            'function': 'GLOBAL_QUOTE',
            'symbol': symbol,
            'apikey': _apiKey,
          },
        );

        final priceData = priceResponse.data['Global Quote'];
        if (priceData == null) {
          throw MainException('No price data found for symbol: $symbol');
        }

        final price = double.tryParse(priceData['05. price'] as String) ?? 0.0;
        stocks.add(StockModel(
            companyName: symbolCompanyName, symbol: symbol, sharePrice: price));
      }

      return stocks;
    } catch (e) {
      // Catch and handle any error during the process
      log('Error in StockService: ${e.toString()}');
      throw MainException('Failed to fetch stock data: ${e.toString()}');
    }
  }
}
