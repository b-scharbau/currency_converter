import 'package:currency_converter/converter/data/model/currency.dart';

class ExchangeRate {
  ExchangeRate(
      {required this.other,
      required this.rate});

  final Currency other;
  final double rate;
}
