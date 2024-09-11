import 'package:hive/hive.dart';
part 'stock_model.g.dart';

@HiveType(typeId: 1)
class StockModel extends HiveObject {
  @HiveField(0)
  final String symbol;         
  
  @HiveField(1)
  final double sharePrice;     
  StockModel({
    required this.symbol,
    required this.sharePrice,
  });

}
