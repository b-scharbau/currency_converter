import 'package:currency_converter/converter/converter_event.dart';
import 'package:currency_converter/converter/converter_factory.dart';
import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_converter_component_test.mocks.dart';

@GenerateMocks([CurrencyRepository, ConverterFactory])
void main() {
  final repository = MockCurrencyRepository();
  final factory = MockConverterFactory();

  final testCurrency = Currency.euro();
  final testTargetCurrencyList = [Currency.dollar(), Currency.yen()];
  final testConverter = CurrencyConverter(
      currency: testCurrency,
      targetCurrencyList: testTargetCurrencyList
  );

  late CurrencyConverterComponent instance;

  setUp(() {
    instance = CurrencyConverterComponent(
      factory: factory,
      repository: repository);
  });

  tearDown(() {
    instance.dispose();

    reset(factory);
    reset(repository);
  });

  group('selectCurrency(string code)', () {
    setUp(() {
      when(repository.getCurrencyForCode('EUR'))
          .thenAnswer((realInvocation) async {
        return testCurrency;
      });

      when(repository.getCurrencies())
          .thenAnswer((realInvocation) async {
        return testTargetCurrencyList;
      });

      when(factory.create())
        .thenReturn(testConverter);
    });

    test('gets currency from repository', () async {
      await instance.selectCurrency(code: 'EUR');

      verify(repository.getCurrencyForCode('EUR')).called(1);
    });

    test('gets currencyList from repository', () async {
      await instance.selectCurrency(code: 'EUR');

      verify(repository.getCurrencies()).called(1);
    });

    test('sets currency on factory', () async {
      await instance.selectCurrency(code: 'EUR');

      verify(factory.currency = (testCurrency)).called(1);
    });

    test('sets targetCurrencyList on factory', () async {
      await instance.selectCurrency(code: 'EUR');

      verify(factory.targetCurrencyList = (testTargetCurrencyList)).called(1);
    });

    test('calls create() on factory', () async {
      await instance.selectCurrency(code: 'EUR');

      verify(factory.create()).called(1);
    });

    test('emits a ConverterEvent', () async {
      await instance.selectCurrency(code: 'EUR');

      verify(factory.create()).called(1);
    });

    test('emit ConversionResultEvent', () async {
      expectLater(instance.currencyEventObservable,
          emits(predicate<ConverterEvent>((value) {
            return value.converter == testConverter;
          })));

      await instance.selectCurrency(code: 'EUR');
    });
  });
}
