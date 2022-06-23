import 'dart:async';

import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/currency_repository.dart';
import 'package:currency_converter/converter/model/conversion_currency_event.dart';
import 'package:currency_converter/converter/model/conversion_event.dart';
import 'package:currency_converter/converter/model/conversion_result_event.dart';
import 'package:currency_converter/converter/model/conversion_table_event.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:currency_converter/ui/conversion_table_widget.dart';
import 'package:currency_converter/ui/model/conversion_table.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyConverterComponent {
  final BehaviorSubject<ConversionEvent> subject = BehaviorSubject();
  final CurrencyRepository _repository;
  final CurrencyConverter _converter;

  Stream<ConversionEvent> get currencyValueObservable => subject.stream;

  CurrencyConverterComponent({repository, converter}) : _repository = repository ?? CurrencyRepository(), _converter = converter ?? CurrencyConverter(currency: Currency.euro());

  Future<void> convert({required String from, required String to, required double amount}) async {
    final currency = await _repository.getCurrencyForCode(from);
    _converter.currency = currency;
    final result = _converter.convert(to: to, amount: amount);

    subject.add(ConversionResultEvent(convertedAmount: result));
  }

  Future<void> generateTable({required CurrencySymbol from, required CurrencySymbol to}) async {
    final currency = await _repository.getCurrencyForCode(from.code);
    _converter.currency = currency;

    final result = ConversionTable(
        from: from,
        rowData: [
          ConversionRow(left: 1, right: _converter.convert(to: to.code, amount: 1)),
          ConversionRow(
              left: 10, right: _converter.convert(to: to.code, amount: 10)),
          ConversionRow(
              left: 100, right: _converter.convert(to: to.code, amount: 100)),
          ConversionRow(
              left: 1000, right: _converter.convert(to: to.code, amount: 1000)),
          ConversionRow(
              left: 10000, right: _converter.convert(to: to.code, amount: 10000)),
        ],
        to: to);
    subject.add(ConversionTableEvent(conversionTable: result));
  }

  void getAvailableCurrencies() {
    final result = [
      CurrencySymbol.dollar(),
      CurrencySymbol.euro(),
      CurrencySymbol.yen()
    ];

    subject.add(ConversionCurrencyEvent(currencyList: result));
  }

  Future<void> dispose() async {
    await subject.close();
  }
}
