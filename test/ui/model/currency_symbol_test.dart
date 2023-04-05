import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/ui/model/currency.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CurrencySymbol instance;

  group('constructors', () {
    group('dollar', () {
      test('Returns correct currency', () {
        final result = CurrencySymbol.dollar();

        expect(result.code, 'USD');
        expect(result.description, 'United States Dollar');
      });
    });

    group('euro', () {
      test('Returns correct currency', () {
        final result = CurrencySymbol.euro();

        expect(result.code, 'EUR');
        expect(result.description, 'Euro');
      });
    });

    group('yen', () {
      test('Returns correct currency', () {
        final result = CurrencySymbol.yen();

        expect(result.code, 'JPY');
        expect(result.description, 'Japanese Yen');
      });
    });
  });

  group('==', () {
    setUp(() {
      instance = CurrencySymbol.euro();
    });

    group('Same class', () {
      group('same object', () {
        test('returns true', () {
          final result = instance == instance;

          expect(result, true);
        });
      });

      group('other object', () {
        group('same code', () {
          final other = CurrencySymbol(code: 'EUR', description: 'Other Euro');

          test('returns true', () {
            final result = instance == other;

            expect(result, true);
          });
        });

        group('different code', () {
          final other = CurrencySymbol(code: 'USD', description: 'Other Dollar');

          test('returns false', () {
            final result = instance == other;

            expect(result, false);
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
      instance = CurrencySymbol.euro();
    });

    test('returns hash of code', () {
      final result = instance.hashCode;

      expect(result, 'EUR'.hashCode);
    });
  });
}
