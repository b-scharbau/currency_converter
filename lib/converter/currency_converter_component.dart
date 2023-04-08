import 'dart:async';

import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/converter/converter_event.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyConverterComponent {
  CurrencyConverterComponent({required repository})
      : _repository = repository;

  Stream<ConverterEvent> get currencyEventObservable => _subject.stream;

  final CurrencyRepository _repository;
  final BehaviorSubject<ConverterEvent> _subject = BehaviorSubject();

  Future<void> selectCurrency({required String code}) async {
    final currencyList = await _repository.getCurrencies();
    final currency = await _repository.getCurrencyForCode(code);

    currencyList.removeWhere((element) => element.code == code);

    CurrencyConverter converter = CurrencyConverter(currency: currency, targetCurrencyList: currencyList);

    _subject.add(ConverterEvent(converter: converter));
  }

  Future<void> dispose() async {
    await _subject.close();
  }
}
