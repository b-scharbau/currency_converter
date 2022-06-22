import 'dart:async';

import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/currency_repository.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:currency_converter/ui/conversion_table.dart';
import 'package:rxdart/rxdart.dart';

class ConversionTableComponent {
  final subject = BehaviorSubject<ConversionData>();

  Stream<ConversionData> get conversionTableObservable => subject.stream;

  final CurrencyRepository _repository;
  final CurrencyConverter _converter;

  ConversionTableComponent({repository, converter})
      : _repository = repository ?? CurrencyRepository(),
        _converter = converter ?? CurrencyConverter(currency: Currency.euro());

  Future<void> generateTable({required String from, required String to}) async {
    final currency = await _repository.getCurrencyForCode(from);
    _converter.currency = currency;

    final result = ConversionData(
        from: from,
        rowData: [
          ConversionRow(left: 1, right: _converter.convert(to: to, amount: 1)),
          ConversionRow(
              left: 10, right: _converter.convert(to: to, amount: 10)),
          ConversionRow(
              left: 100, right: _converter.convert(to: to, amount: 100)),
          ConversionRow(
              left: 1000, right: _converter.convert(to: to, amount: 1000)),
          ConversionRow(
              left: 10000, right: _converter.convert(to: to, amount: 10000)),
        ],
        to: to);
    subject.add(result);
  }

  Future<void> dispose() async {
    await subject.close();
  }
}
