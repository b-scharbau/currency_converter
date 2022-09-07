import 'package:currency_converter/converter/data/model/currency.dart';

abstract class DataSource {
  Future<List<Currency>> getCurrencies();
  Future<Currency> getCurrencyByCode(String code);
}