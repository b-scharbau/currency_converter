import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Currency instance;

  setUp(() {
    instance = Currency(
        code: 'EUR',
        date: DateTime.now(),
        description: 'Euro',
        exchangeRates: {'JPY': 140.881056});
  });
}
