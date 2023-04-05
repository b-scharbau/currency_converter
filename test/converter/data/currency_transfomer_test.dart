import 'package:currency_converter/converter/data/currency_transformer.dart';
import 'package:currency_converter/converter/data/model/currency.dart' as data;
import 'package:currency_converter/ui/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CurrencyTransformer instance = CurrencyTransformer();

  group('transform(Currency currency)', () {

    test('Returns correct value', () async {
      var input = data.Currency.yen();

      var expectedResult = Currency.yen();

      final result = instance.transform(input);

      expect(result.code, expectedResult.code);
      expect(result.date, expectedResult.date);
      expect(result.description, expectedResult.description);
      expect(result.exchangeRates, expectedResult.exchangeRates);
    });
  });
}
