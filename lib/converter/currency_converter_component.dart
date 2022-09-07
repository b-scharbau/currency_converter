import 'dart:async';

import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/converter/model/conversion_currency_event.dart';
import 'package:currency_converter/converter/model/conversion_event.dart';
import 'package:currency_converter/converter/model/conversion_result_event.dart';
import 'package:currency_converter/converter/model/conversion_table_event.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:currency_converter/ui/model/conversion_row.dart';
import 'package:currency_converter/ui/model/conversion_table.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyConverterComponent {
  CurrencyConverterComponent({repository, converter})
      : _repository = repository ?? CurrencyRepository(),
        _converter = converter ?? CurrencyConverter(currency: Currency.euro());

  Stream<ConversionEvent> get currencyEventObservable => _subject.stream;

  final CurrencyConverter _converter;
  final CurrencyRepository _repository;
  final BehaviorSubject<ConversionEvent> _subject = BehaviorSubject();

  Future<void> convert(
      {required String from,
      required String to,
      required double amount}) async {
    final currency = await _repository.getCurrencyForCode(from);
    _converter.currency = currency;
    final result = _converter.convert(to: to, amount: amount);

    _subject.add(ConversionResultEvent(convertedAmount: result));
  }

  Future<void> dispose() async {
    await _subject.close();
  }

  Future<void> generateConversionTable(
      {required CurrencySymbol from, required CurrencySymbol to}) async {
    final currency = await _repository.getCurrencyForCode(from.code);
    _converter.currency = currency;

    final result = ConversionTable(
        from: from,
        rowData: [
          ConversionRow(
              left: 1, right: _converter.convert(to: to.code, amount: 1)),
          ConversionRow(
              left: 10, right: _converter.convert(to: to.code, amount: 10)),
          ConversionRow(
              left: 100, right: _converter.convert(to: to.code, amount: 100)),
          ConversionRow(
              left: 1000, right: _converter.convert(to: to.code, amount: 1000)),
          ConversionRow(
              left: 10000,
              right: _converter.convert(to: to.code, amount: 10000)),
        ],
        to: to);
    _subject.add(ConversionTableEvent(conversionTable: result));
  }

  Future<void> getAvailableCurrencies() async {
    final result = await _repository.getCurrencies();

    _subject.add(ConversionCurrencyEvent(
        currencyList: result.map((currency) => CurrencySymbol(
            code: currency.code,
            description: currency.description)).toList(growable: false)));
  }
}
