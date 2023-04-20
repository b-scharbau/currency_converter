import 'dart:convert';
import 'dart:developer' as developer;

import 'package:currency_converter/model/currency.dart';

import 'package:http/http.dart' as http;

class RemoteDataSource {
  Future<List<Currency>> getCurrencies() async {
    var response = await http.get(Uri.parse('https://currency-api.bscharbau.com/symbols'));

    if (response.statusCode == 200) {
      var currencyList = jsonDecode(response.body)['symbols'];
      return List.generate(currencyList.length, (i) {
        return Currency(
            code: currencyList[i]['symbol'],
            date: DateTime.parse(currencyList[i]['date']),
            description: currencyList[i]['description'],
            exchangeRates: {}
        );
      });
    } else {
      throw Exception('Could not retrieve currency information');
    }
  }

  Future<Currency> getCurrencyByCode(String code) async {
    var response = await http.get(Uri.parse('https://currency-api.bscharbau.com/symbols/$code'));

    if (response.statusCode == 200) {
      return Currency.fromJson(jsonDecode(response.body)['symbol']);
    } else {
      throw Exception('Could not retrieve currency information');
    }
  }
}
