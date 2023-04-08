
import 'package:currency_converter/model/currency.dart';

abstract class DataSource {
  Future<List<Currency>> getCurrencies();
  Future<Currency> getCurrencyByCode(String code);
}