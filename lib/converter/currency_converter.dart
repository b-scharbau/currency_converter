import 'package:currency_converter/ui/model/currency.dart';

class CurrencyConverter {
  CurrencyConverter({required this.currency, required this.targetCurrencyList});

  final Currency currency;
  final List<Currency> targetCurrencyList;

  double convert({required double amount, required String to}) {
    return amount * currency.exchangeRates[to]!;
  }

  DateTime date() {
    return currency.date;
  }
}