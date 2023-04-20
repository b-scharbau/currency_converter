import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/model/currency.dart';

class ConverterFactory {
  Currency? currency;
  List<Currency>? targetCurrencyList;

  CurrencyConverter create() {
    if (currency == null || targetCurrencyList == null) {
      throw ArgumentError('Parameter not set properly');
    }
    return CurrencyConverter(currency: currency!, targetCurrencyList: targetCurrencyList!);
  }
}