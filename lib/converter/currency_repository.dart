import 'package:currency_converter/converter/model/currency.dart';

class CurrencyRepository {
  final Set<Currency> _currencyList = { Currency.dollar(), Currency.euro(), Currency.yen() };

  Future<Currency> getCurrencyForCode(String code) async {

    return _currencyList.firstWhere((element) => element.code == code);
  }

  Future<List<Currency>> getCurrencies() async {
    return _currencyList.toList(growable: false);
  }
}
