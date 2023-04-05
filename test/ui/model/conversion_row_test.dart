import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/ui/model/currency.dart';
import 'package:currency_converter/ui/model/conversion_row.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ConversionRow instance;

  group('==', () {
    setUp(() {
      instance = ConversionRow(left: 10.0, right: 10.0);
    });

    group('Same class', () {
      group('same object', () {
        test('returns true', () {
          final result = instance == instance;

          expect(result, true);
        });
      });

      group('other object', () {
        group('same left', () {
          const left = 10.0;

          group('same right', () {
            const right = 10.0;

            final other = ConversionRow(left: left, right: right);

            test('returns true', () {
              final result = instance == other;

              expect(result, true);
            });
          });

          group('different right', () {
            const right = 42.0;

            final other = ConversionRow(left: left, right: right);

            test('returns false', () {
              final result = instance == other;

              expect(result, false);
            });
          });
        });

        group('different left', () {
          const left = 42.0;

          group('same right', () {
            const right = 10.0;

            final other = ConversionRow(left: left, right: right);

            test('returns false', () {
              final result = instance == other;

              expect(result, false);
            });
          });

          group('different right', () {
            const right = 42.0;

            final other = ConversionRow(left: left, right: right);

            test('returns false', () {
              final result = instance == other;

              expect(result, false);
            });
          });
        });
      });
    });

    group('different class', () {
      test('returns false', () {
        final result = instance == 'other';

        expect(result, false);
      });
    });
  });

  group('hashcode', () {
    setUp(() {
      instance = ConversionRow(left: 10.0, right: 10.0);
    });

    test('returns hash of code', () {
      final result = instance.hashCode;

      expect(result, '10.0-10.0'.hashCode);
    });
  });
}
