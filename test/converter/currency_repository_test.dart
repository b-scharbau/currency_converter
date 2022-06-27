import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/currency_repository.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CurrencyRepository instance = CurrencyRepository();

  group('getCurrencies(String code)', () {
    group('existing currency', () {
      test('Returns correct value', () async {
        final result = await instance.getCurrencyForCode('JPY');

        expect(result.code, 'JPY');
      });
    });

    group('non existing currency', () {
      test('throws an error', () async {
        expect(() async{
          await instance.getCurrencyForCode('DM');
        }, throwsA(const TypeMatcher<StateError>()));
      });
    });
  });

  group('getCurrencies()', () {
    test('returns currencies', () async {
      final result = await instance.getCurrencies();

      expect(result.length, 3);
      expect(result[0].code, 'USD');
      expect(result[1].code, 'EUR');
      expect(result[2].code, 'JPY');
    });
  });
}
