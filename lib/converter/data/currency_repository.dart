import 'package:currency_converter/converter/data/data_source.dart';
import 'package:currency_converter/model/currency.dart';


class CurrencyRepository {
  final Set<Currency> _currencyList = {  };

  final DataSource localDataSource;
  final DataSource remoteDataSource;

  CurrencyRepository({required this.localDataSource, required this.remoteDataSource});

  Future<Currency> getCurrencyForCode(String code) async {
    late final Currency currency;
    try {
      currency = await  remoteDataSource.getCurrencyByCode(code);
    } catch(e) {
      currency = await  localDataSource.getCurrencyByCode(code);
    }
    return currency;
  }

  Future<List<Currency>> getCurrencies() async {
    if (_currencyList.isEmpty) {
      late final List<Currency> currencies;
      try {
        currencies = await remoteDataSource.getCurrencies();
      } catch(e) {
        currencies = await localDataSource.getCurrencies();
      }

      _currencyList.addAll(currencies);
    }

    return _currencyList.toList();
  }
}

