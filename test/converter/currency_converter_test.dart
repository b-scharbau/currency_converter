import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CurrencyConverter instance;

  setUp(() {
    instance = CurrencyConverter(currency: Currency.euro());
  });

  group('convert', () {
    group('positive value', () {
      test('Correctly converts value', () async {
        final result = instance.convert(to: 'JPY', amount: 100.0);

        expect(result, 14088.1056);
      });
    });

    group('zero', () {
      test('Correctly converts value', () async {
        final result = instance.convert(to: 'JPY', amount: 0.0);

        expect(result, 0.0);
      });
    });

    group('negative value', () {
      test('Correctly converts value', () async {
        final result = instance.convert(to: 'JPY', amount: -100.0);

        expect(result, -14088.1056);
      });
    });
  });
}
