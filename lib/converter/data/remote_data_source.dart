import 'dart:convert';
import 'dart:developer' as developer;

import 'package:currency_converter/converter/data/data_source.dart';
import 'package:currency_converter/ui/model/currency.dart';

import 'package:http/http.dart' as http;

class RemoteDataSource implements DataSource {
  @override
  Future<List<Currency>> getCurrencies() {
    // TODO: implement getCurrencies
    throw UnimplementedError();
  }

  @override
  Future<Currency> getCurrencyByCode(String code) async {
    var response = await http.get(Uri.parse('https://currency-api.bscharbau.com/symbols/$code'));

    if (response.statusCode == 200) {
      return Currency.fromJson(jsonDecode(response.body)['symbol']);
    } else {
      throw Exception('Could not retrieve currency information');
    }
  }
}
