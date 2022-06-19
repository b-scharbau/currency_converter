
import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/currency_repository.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_converter_component_test.mocks.dart';

@GenerateMocks([CurrencyRepository])
void main() {
  final repository = MockCurrencyRepository();
  late CurrencyConverterComponent instance;

  setUp(() {
    instance = CurrencyConverterComponent(repository: repository);
  });

  tearDown(() {
    instance.dispose();

    reset(repository);
  });

  group('convert(double value', () {
    setUp(() {
      when(repository.getCurrencyForCode('EUR')).thenAnswer((realInvocation) async {
        return Currency(
            code: 'EUR',
            date: DateTime.now(),
            description: '',
            exchangeRates: {'JPY': 150});
      });
    });

    group('positive value', () {
      test('Correctly converts value', () async {
        expectLater(
            instance.currencyValueObservable, emits(15000));

        instance.convert(from: 'EUR', to: 'JPY', amount: 100.0);
      });
    });

    group('zero', () {
      test('Correctly converts value', () async {
        expectLater(
            instance.currencyValueObservable, emits(0.0));

        instance.convert(from: 'EUR', to: 'JPY', amount: 0.0);
      });
    });

    group('negative value', () {
      test('Correctly converts value', () async {
        expectLater(
            instance.currencyValueObservable, emits(-15000));

        instance.convert(from: 'EUR', to: 'JPY', amount: -100.0);
      });
    });
  });
}
