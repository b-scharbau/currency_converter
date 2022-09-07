import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/converter/model/conversion_currency_event.dart';
import 'package:currency_converter/converter/model/conversion_result_event.dart';
import 'package:currency_converter/converter/model/conversion_table_event.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:currency_converter/ui/model/conversion_row.dart';
import 'package:currency_converter/ui/model/conversion_table.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:collection/collection.dart';

import 'currency_converter_component_test.mocks.dart';

@GenerateMocks([CurrencyRepository, CurrencyConverter])
void main() {
  final repository = MockCurrencyRepository();
  final converter = MockCurrencyConverter();

  final testCurrency = Currency(
      code: 'EUR',
      date: DateTime.now(),
      description: '',
      exchangeRates: {'JPY': 150});

  late CurrencyConverterComponent instance;

  setUp(() {
    instance = CurrencyConverterComponent(
        converter: converter, repository: repository);
  });

  tearDown(() {
    instance.dispose();

    reset(repository);
    reset(converter);
  });

  group('convert(double value)', () {
    setUp(() {
      when(repository.getCurrencyForCode('EUR'))
          .thenAnswer((realInvocation) async {
        return testCurrency;
      });

      when(converter.currency = (any)).thenReturn(null);
      when(converter.convert(amount: anyNamed('amount'), to: anyNamed('to')))
          .thenReturn(15000);
    });

    test('gets currency from repository', () async {
      await instance.convert(from: 'EUR', to: 'JPY', amount: 100.0);

      verify(repository.getCurrencyForCode('EUR')).called(1);
    });

    test('sets currency on converter', () async {
      await instance.convert(from: 'EUR', to: 'JPY', amount: 100.0);

      verify(converter.currency = (testCurrency)).called(1);
    });

    test('calls convert on CurrencyConverter with correct arguments', () async {
      await instance.convert(from: 'EUR', to: 'JPY', amount: 100.0);

      verify(converter.convert(amount: 100, to: 'JPY'));
    });

    test('emit ConversionResultEvent', () async {
      expectLater(instance.currencyEventObservable,
          emits(predicate<ConversionResultEvent>((value) {
        return value.convertedAmount == 15000;
      })));

      await instance.convert(from: 'EUR', to: 'JPY', amount: 100.0);
    });
  });

  group('generateConversionTable(Currency from, Currency to)', () {
    final fromCurrency = CurrencySymbol(code: 'EUR', description: 'Euro');
    final toCurrency = CurrencySymbol(code: 'JPY', description: 'Japanese Yen');

    setUp(() {
      when(repository.getCurrencyForCode('EUR'))
          .thenAnswer((realInvocation) async {
        return testCurrency;
      });

      when(converter.currency = (any)).thenReturn(null);
      when(converter.convert(amount: 1, to: anyNamed('to'))).thenReturn(150);
      when(converter.convert(amount: 10, to: anyNamed('to'))).thenReturn(1500);
      when(converter.convert(amount: 100, to: anyNamed('to')))
          .thenReturn(15000);
      when(converter.convert(amount: 1000, to: anyNamed('to')))
          .thenReturn(150000);
      when(converter.convert(amount: 10000, to: anyNamed('to')))
          .thenReturn(1500000);
    });

    test('gets currency from repository', () async {
      await instance.generateConversionTable(
          from: fromCurrency, to: toCurrency);

      verify(repository.getCurrencyForCode('EUR')).called(1);
    });

    test('sets currency on converter', () async {
      await instance.generateConversionTable(
          from: fromCurrency, to: toCurrency);

      verify(converter.currency = (testCurrency)).called(1);
    });

    test('calls convert on CurrencyConverter with correct arguments', () async {
      await instance.generateConversionTable(
          from: fromCurrency, to: toCurrency);

      verify(converter.convert(amount: 1, to: 'JPY'));
      verify(converter.convert(amount: 10, to: 'JPY'));
      verify(converter.convert(amount: 100, to: 'JPY'));
      verify(converter.convert(amount: 1000, to: 'JPY'));
      verify(converter.convert(amount: 10000, to: 'JPY'));
    });

    test('emit ConversionTableEvent', () async {
      ConversionTable expectedResult =
          ConversionTable(from: fromCurrency, rowData: [
            ConversionRow(left: 1.0, right: 150),
            ConversionRow(left: 10.0, right: 1500),
            ConversionRow(left: 100.0, right: 15000),
            ConversionRow(left: 1000.0, right: 150000),
            ConversionRow(left: 10000.0, right: 1500000),
          ], to: toCurrency);

      expectLater(instance.currencyEventObservable,
          emits(predicate<ConversionTableEvent>((value) {
        return value.conversionTable.equals(expectedResult);
      })));

      await instance.generateConversionTable(
          from: fromCurrency, to: toCurrency);
    });
  });

  group('getAvailableCurrencies()', () {
    setUp(() {
      when(repository.getCurrencies())
          .thenAnswer((realInvocation) async {
        return [testCurrency];
      });
    });

    test('gets currencies from repository', () async {
      await instance.getAvailableCurrencies();

      verify(repository.getCurrencies()).called(1);
    });

    test('emit ConversionCurrencyEvent', () async {
      List<CurrencySymbol> expectedResult = [
        CurrencySymbol(code: 'EUR', description: 'Euro')
      ];

      expectLater(instance.currencyEventObservable,
          emits(predicate<ConversionCurrencyEvent>((value) {
            return const ListEquality().equals(value.currencyList, expectedResult);
          })));

      await instance.getAvailableCurrencies();
    });
  });
}
