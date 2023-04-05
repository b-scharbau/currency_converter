import 'package:currency_converter/ui/model/currency.dart';
import 'package:currency_converter/converter/data/model/currency.dart' as data;

class CurrencyTransformer {
  Currency transform(data.Currency currency) {
    Map<String, double> rates = {};

    for (var exchangeRate in currency.exchangeRates) {
      rates[exchangeRate.other.code] = exchangeRate.rate;
    }

    return Currency(code: currency.code, date: currency.date, description: currency.description, exchangeRates: rates);
  }
}