import 'package:currency_converter/converter/data/local_data_source.dart';
import 'package:currency_converter/converter/data/remote_data_source.dart';
import 'package:currency_converter/model/currency.dart';

import 'dart:developer' as developer;

class CurrencyRepository {
  final Set<Currency> _currencyList = {  };

  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  CurrencyRepository({
    required this.localDataSource,
    required this.remoteDataSource
  });

  Stream<Currency> getCurrencyForCode(String code) async* {
    late Currency currency;

    try {
      currency = await localDataSource.getCurrencyByCode(code);

      yield currency;

      DateTime date = DateTime.now();
      date = date.subtract(const Duration(days: 1));

      if (currency.date.isBefore(date)) {
        try {
          currency = await _getRemoteCurrency(code);
          yield currency;
        } catch(e) {
          developer.log("Couldn't fetch new currency data from backend");
        }
      }
    } catch(e) {
      try {
        currency = await _getRemoteCurrency(code);
        yield currency;
      } catch(e) {
        developer.log("Couldn't fetch new currency data from backend");
      }
    }
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

  Future<Currency> _getRemoteCurrency(String code) async {
    late Currency currency;

    currency = await remoteDataSource.getCurrencyByCode(code);
    localDataSource.updateCurrency(currency);

    return currency;
  }
}