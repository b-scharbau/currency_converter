import 'package:currency_converter/converter/data/currency_transformer.dart';
import 'package:currency_converter/converter/data/data_source.dart';
import 'package:currency_converter/converter/model/currency.dart';


class CurrencyRepository {
  final Set<Currency> _currencyList = { Currency.dollar(), Currency.euro(), Currency.yen() };

  DataSource localDataSource;

  CurrencyRepository(this.localDataSource);

  Future<Currency> getCurrencyForCode(String code) async {
    var currency = _currencyList.where(
            (element) => element.code == code);

    if (currency.isNotEmpty) {
      return currency.first;
    }

    var transformer = CurrencyTransformer();
    var newCurrency = transformer.transform(await localDataSource.getCurrencyByCode(code));

    _currencyList.add(newCurrency);
    return newCurrency;
  }

  Future<List<Currency>> getCurrencies() async {
    return _currencyList.toList(growable: false);
  }
}

