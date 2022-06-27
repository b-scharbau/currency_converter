import 'package:currency_converter/converter/model/currency.dart';

class CurrencyConverter {
  CurrencyConverter({required this.currency});

  Currency currency;

  double convert({required double amount, required String to}) {
    return amount * currency.exchangeRates[to]!;
  }
}