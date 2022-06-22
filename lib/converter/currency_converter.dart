import 'package:currency_converter/converter/model/currency.dart';

class CurrencyConverter {
  CurrencyConverter({required this.currency});

  Currency currency;

  double convert({required String to, required double amount}) {
    return amount * currency.exchangeRates[to]!;
  }
}