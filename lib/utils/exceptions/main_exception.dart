class MainException implements Exception {
  final String message;
  MainException(this.message);

  @override
  String toString() => 'StockServiceException: $message';
}
