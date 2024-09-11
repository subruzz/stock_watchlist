import 'package:dio/dio.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/utils/constants/secrets.dart';
import 'package:stock_watchlist/utils/exceptions/main_exception.dart'; // Import your exception class

class StockService {
  final Dio _dio = Dio();
  final String _apiKey = alphaVantageKey;

  Future<List<StockModel>> searchStocks(String query) async {
    try {
      final response = await _dio.get(
        'https://www.alphavantage.co/query',
        queryParameters: {
          'function': 'SYMBOL_SEARCH',
          'keywords': query,
          'apikey': _apiKey,
        },
      );

      // Check for API response status
      switch (response.statusCode) {
        case 200:
          break;
        case 400:
          throw MainException(
              'Bad request: The request could not be understood or was missing required parameters.');
        case 401:
          throw MainException('Unauthorized: API key is invalid.');
        case 403:
          throw MainException('Forbidden: Access is denied.');
        case 404:
          throw MainException(
              'Not Found: The requested resource could not be found.');
        case 500:
          throw MainException(
              'Internal Server Error: An error occurred on the server.');
        case 503:
          throw MainException(
              'Service Unavailable: The server is currently unable to handle the request.');
        default:
          throw MainException('Unexpected status code: ${response.statusCode}');
      }

      // Extract the list of best matches
      final List<dynamic>? matches = response.data['bestMatches'];
      if (matches == null) {
        throw MainException('No matches found in the response data');
      }

      final List<StockModel> stocks = [];

      for (var match in matches) {
        final symbol = match['1. symbol'] as String;

        try {
          // Fetch the latest price for the stock symbol
          final priceResponse = await _dio.get(
            'https://www.alphavantage.co/query',
            queryParameters: {
              'function': 'GLOBAL_QUOTE',
              'symbol': symbol,
              'apikey': _apiKey,
            },
          );

          // Check for price API response status
          switch (priceResponse.statusCode) {
            case 200:
              break;
            case 400:
              throw MainException(
                  'Bad request for price data: The request could not be understood or was missing required parameters.');
            case 401:
              throw MainException(
                  'Unauthorized for price data: API key is invalid.');
            case 403:
              throw MainException(
                  'Forbidden for price data: Access is denied.');
            case 404:
              throw MainException(
                  'Not Found for price data: The requested resource could not be found.');
            case 500:
              throw MainException(
                  'Internal Server Error for price data: An error occurred on the server.');
            case 503:
              throw MainException(
                  'Service Unavailable for price data: The server is currently unable to handle the request.');
            default:
              throw MainException(
                  'Unexpected status code for price data: ${priceResponse.statusCode}');
          }

          final priceData = priceResponse.data['Global Quote'];
          if (priceData == null) {
            throw MainException('No price data found in the response');
          }

          final price = double.parse(priceData['05. price'] as String);
          stocks.add(StockModel(symbol: symbol, sharePrice: price));
        } catch (e) {
          if (e is DioException) {
            final dioError = e;
            if (dioError.type == DioExceptionType.connectionTimeout) {
              throw MainException('Connection timeout occurred');
            } else if (dioError.type == DioExceptionType.sendTimeout) {
              throw MainException('Send timeout occurred');
            } else if (dioError.type == DioExceptionType.receiveTimeout) {
              throw MainException('Receive timeout occurred');
            } else if (dioError.type == DioExceptionType.badResponse) {
              throw MainException(
                  'Received invalid status code: ${dioError.response?.statusCode}');
            } else if (dioError.type == DioExceptionType.cancel) {
              throw MainException('Request was cancelled');
            } else {
              throw MainException(
                  'Network error occurred: ${dioError.message}');
            }
          } else if (e is FormatException) {
            throw MainException('Failed to parse stock price data');
          } else {
            throw MainException('An unknown error occurred: $e');
          }
        }
      }

      return stocks;
    } catch (e) {
      if (e is MainException) {
        rethrow;
      } else {
        throw MainException(
            'An unexpected error occurred: $e'); 
      }
    }
  }
}
