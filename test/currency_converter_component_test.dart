
import 'package:currency_converter/currency_converter_component.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CurrencyConverterComponent instance;

  setUp(() {
    instance = CurrencyConverterComponent();
  });

  tearDown(() {
    instance.dispose();
  });

  group('convert(double value', () {
    group('positive value', () {
      test('Correctly converts value', () async {
        expectLater(
            instance.currencyValueObservable, emits(14042.133000000002));

        instance.convert(100.0);
      });
    });

    group('zero', () {
      test('Correctly converts value', () async {
        expectLater(
            instance.currencyValueObservable, emits(0.0));

        instance.convert(0.0);
      });
    });

    group('negative value', () {
      test('Correctly converts value', () async {
        expectLater(
            instance.currencyValueObservable, emits(-14042.133000000002));

        instance.convert(-100.0);
      });
    });
  });
}
