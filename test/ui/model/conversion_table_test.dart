import 'package:currency_converter/ui/model/conversion_row.dart';
import 'package:currency_converter/ui/model/conversion_table.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ConversionTable instance;

  group('equals(ConversionTable other)', () {
    final fromCurrency = CurrencySymbol.euro();
    final toCurrency = CurrencySymbol.yen();

    setUp(() {
      instance = ConversionTable(
        from: fromCurrency,
        rowData: [
          ConversionRow(left: 10.0, right: 10.0)
        ],
        to: toCurrency
      );
    });

    group('same object', () {
      test('returns true', () {
        final result = instance.equals(instance);

        expect(result, true);
      });
    });

    group('other object', () {
      group('same fromCurrency', () {
        final otherFromCurrency = CurrencySymbol.euro();

        group('same toCurrency', () {
          final otherToCurrency = CurrencySymbol.yen();

          group('same table data', () {
            final otherData = ConversionRow(left: 10.0, right: 10.0);

            final other = ConversionTable(
                from: otherFromCurrency,
                rowData: [
                  otherData
                ],
                to: otherToCurrency
            );

            test('returns true', () {
              final result = instance.equals(other);

              expect(result, true);
            });
          });

          group('different table data', () {
            final otherData = ConversionRow(left: 42.0, right: 42.0);

            final other = ConversionTable(
                from: otherFromCurrency,
                rowData: [
                  otherData
                ],
                to: otherToCurrency
            );

            test('returns false', () {
              final result = instance.equals(other);

              expect(result, false);
            });
          });
        });

        group('different toCurrency', () {
          final otherToCurrency = CurrencySymbol.dollar();

          group('same table data', () {
            final otherData = ConversionRow(left: 10.0, right: 10.0);

            final other = ConversionTable(
                from: otherFromCurrency,
                rowData: [
                  otherData
                ],
                to: otherToCurrency
            );

            test('returns false', () {
              final result = instance.equals(other);

              expect(result, false);
            });
          });

          group('different table data', () {
            final otherData = ConversionRow(left: 42.0, right: 42.0);

            final other = ConversionTable(
                from: otherFromCurrency,
                rowData: [
                  otherData
                ],
                to: otherToCurrency
            );

            test('returns false', () {
              final result = instance.equals(other);

              expect(result, false);
            });
          });
        });
      });

      group('different fromCurrency', () {
        final otherFromCurrency = CurrencySymbol.dollar();

        group('same toCurrency', () {
          final otherToCurrency = CurrencySymbol.yen();

          group('same table data', () {
            final otherData = ConversionRow(left: 10.0, right: 10.0);

            final other = ConversionTable(
                from: otherFromCurrency,
                rowData: [
                  otherData
                ],
                to: otherToCurrency
            );

            test('returns false', () {
              final result = instance.equals(other);

              expect(result, false);
            });
          });

          group('different table data', () {
            final otherData = ConversionRow(left: 42.0, right: 42.0);

            final other = ConversionTable(
                from: otherFromCurrency,
                rowData: [
                  otherData
                ],
                to: otherToCurrency
            );

            test('returns false', () {
              final result = instance.equals(other);

              expect(result, false);
            });
          });
        });

        group('different toCurrency', () {
          final otherToCurrency = CurrencySymbol.dollar();

          group('same table data', () {
            final otherData = ConversionRow(left: 10.0, right: 10.0);

            final other = ConversionTable(
                from: otherFromCurrency,
                rowData: [
                  otherData
                ],
                to: otherToCurrency
            );

            test('returns false', () {
              final result = instance.equals(other);

              expect(result, false);
            });
          });

          group('different table data', () {
            final otherData = ConversionRow(left: 42.0, right: 42.0);

            final other = ConversionTable(
                from: otherFromCurrency,
                rowData: [
                  otherData
                ],
                to: otherToCurrency
            );

            test('returns false', () {
              final result = instance.equals(other);

              expect(result, false);
            });
          });
        });
      });
    });
  });
}
