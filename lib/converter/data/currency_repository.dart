import 'package:currency_converter/converter/data/currency_transformer.dart';
import 'package:currency_converter/converter/data/data_source.dart';
import 'package:currency_converter/ui/model/currency.dart';


class CurrencyRepository {
  final Set<Currency> _currencyList = { Currency.dollar(), Currency.euro(), Currency.yen() };

  DataSource remoteDataSource;

  CurrencyRepository({required this.remoteDataSource});

  Future<Currency> getCurrencyForCode(String code) async {
    return remoteDataSource.getCurrencyByCode(code);
  }

  Future<List<Currency>> getCurrencies() async {
    return _currencyList.toList(growable: true);
  }
}

