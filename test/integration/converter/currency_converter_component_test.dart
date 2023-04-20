import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/converter/model/conversion_currency_event.dart';
import 'package:currency_converter/converter/model/conversion_result_event.dart';
import 'package:currency_converter/converter/model/conversion_table_event.dart';
import 'package:currency_converter/ui/model/currency.dart';
import 'package:currency_converter/ui/model/conversion_row.dart';
import 'package:currency_converter/ui/model/conversion_table.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:collection/collection.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([CurrencyRepository])
void main() {
  late CurrencyConverterComponent instance;

  setUp(() {
    instance = CurrencyConverterComponent();
  });

  tearDown(() {
    instance.dispose();
  });

  group('convert(double value)', () {
    test('emit ConversionResultEvent', () async {
      expectLater(instance.currencyEventObservable,
          emits(predicate<ConversionResultEvent>((value) {
        return value.convertedAmount == 14088.1056;
      })));

      await instance.convert(from: 'EUR', to: 'JPY', amount: 100.0);
    });
  });

  group('generateConversionTable(Currency from, Currency to)', () {
    final fromCurrency = CurrencySymbol(code: 'EUR', description: 'Euro');
    final toCurrency = CurrencySymbol(code: 'JPY', description: 'Japanese Yen');

    test('emit ConversionTableEvent', () async {
      ConversionTable expectedResult =
          ConversionTable(from: fromCurrency, rowData: [
            ConversionRow(left: 1.0, right: 140.881056),
            ConversionRow(left: 10.0, right: 1408.81056),
            ConversionRow(left: 100.0, right: 14088.1056),
            ConversionRow(left: 1000.0, right: 140881.056),
            ConversionRow(left: 10000.0, right: 1408810.56),
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
    test('emit ConversionCurrencyEvent', () async {
      List<CurrencySymbol> expectedResult = [
        CurrencySymbol(code: 'USD', description: 'Dollar'),
        CurrencySymbol(code: 'EUR', description: 'Euro'),
        CurrencySymbol(code: 'JPY', description: 'Yen')
      ];

      expectLater(instance.currencyEventObservable,
          emits(predicate<ConversionCurrencyEvent>((value) {
            return const ListEquality().equals(value.currencyList, expectedResult);
          })));

      await instance.getAvailableCurrencies();
    });
  });
}
