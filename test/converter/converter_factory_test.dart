import 'package:currency_converter/converter/converter_factory.dart';
import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ConverterFactory instance;

  setUp(() {
    instance = ConverterFactory();
  });

  group('create()', () {
    final currency = Currency.euro();
    final targetCurrencyList = [Currency.dollar(), Currency.yen()];

    group('currency and targetCurrencyList set', () {
      setUp(() {
        instance.currency = currency;
        instance.targetCurrencyList = targetCurrencyList;
      });

      test('returns new CurrencyConverter', () {
        final result = instance.create();

        expect(result, isA<CurrencyConverter>());
      });

      test('currency set on created CurrencyConverter', () {
        final result = instance.create();

        expect(result.currency, currency);
      });

      test('targetCurrencyList set on created CurrencyConverter', () {
        final result = instance.create();

        expect(result.targetCurrencyList, targetCurrencyList);
      });
    });

    group('only currency set', () {
      setUp(() {
        instance.currency = currency;
      });

      test('throws an error', () {
        expect(instance.create, throwsA(isA<ArgumentError>()));
      });
    });

    group('only targetCurrencyList set', () {
      setUp(() {
        instance.targetCurrencyList = targetCurrencyList;
      });

      test('throws an error', () {
        expect(instance.create, throwsA(isA<ArgumentError>()));
      });
    });

    group('no data set', () {
      test('throws an error', () {
        expect(instance.create, throwsA(isA<ArgumentError>()));
      });
    });
  });
}
