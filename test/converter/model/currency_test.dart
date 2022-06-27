import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Currency instance;

  group('constructors', () {
    group('dollar', () {
      test('Returns correct currency', () {
        final result = Currency.dollar();

        expect(result.code, 'USD');
        expect(result.date, DateTime(2022, 6, 17));
        expect(result.description, 'United States Dollar');
        expect(result.exchangeRates, {'EUR': 0.95215, 'JPY': 134.409499, 'USD': 1.0});
      });
    });

    group('euro', () {
      test('Returns correct currency', () {
        final result = Currency.euro();

        expect(result.code, 'EUR');
        expect(result.date, DateTime(2022, 6, 17));
        expect(result.description, 'Euro');
        expect(result.exchangeRates, {'EUR': 1.0, 'JPY': 140.881056, 'USD': 1.051481});
      });
    });

    group('yen', () {
      test('Returns correct currency', () {
        final result = Currency.yen();

        expect(result.code, 'JPY');
        expect(result.date, DateTime(2022, 6, 17));
        expect(result.description, 'Japanese Yen');
        expect(result.exchangeRates, {'EUR': 0.007086, 'JPY': 1.0, 'USD': 0.00744});
      });
    });
  });
}
