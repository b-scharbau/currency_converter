import 'package:currency_converter/converter/data/data_source.dart';
import 'package:currency_converter/model/currency.dart';

import 'package:sqflite/sqflite.dart';

class LocalDataSource implements DataSource {
  final Database db;

  LocalDataSource({required this.db});

  @override
  Future<List<Currency>> getCurrencies() async {
    final List<Map<String, dynamic>> maps = await db.query('currencies');

    return List.generate(maps.length, (i) {
      return Currency(
        code: maps[i]['code'],
        date: DateTime.fromMillisecondsSinceEpoch(maps[i]['date']),
        description: maps[i]['description'],
        exchangeRates: {}
      );
    });
  }

  @override
  Future<Currency> getCurrencyByCode(String code) async {
    final List<Map<String, dynamic>> rawCurrency = await db.query('currencies', where: 'code = ?', whereArgs: [code]);
    final List<Map<String, dynamic>> rawRates = await db.query('exchange_rates', where: 'currency = ?', whereArgs: [code]);

    final Map<String, double> exchangeRates = {};

    for (var element in rawRates) {
      exchangeRates[element['other']] = element['rate'];
    }
    return Currency(
        code: rawCurrency.first['code'],
        date: DateTime.fromMillisecondsSinceEpoch(rawCurrency.first['date']),
        description: rawCurrency.first['description'],
        exchangeRates: exchangeRates
    );
  }
}
