import 'dart:async';
import 'dart:convert';

import 'package:currency_converter/converter/converter_factory.dart';
import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/converter/converter_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyConverterComponent {
  CurrencyConverterComponent({
    required CurrencyRepository repository,
    required ConverterFactory factory
  })
      : _repository = repository,
        _converterFactory = factory;

  Stream<ConverterEvent> get currencyEventObservable => _subject.stream;

  final CurrencyRepository _repository;
  final ConverterFactory _converterFactory;
  final BehaviorSubject<ConverterEvent> _subject = BehaviorSubject();

  Future<void> selectCurrency({required String code}) async {
    final currencyList = await _repository.getCurrencies();
    final currency = await _repository.getCurrencyForCode(code);

    currencyList.removeWhere((element) => element.code == code);

    _converterFactory.currency = currency;
    _converterFactory.targetCurrencyList = currencyList;

    CurrencyConverter converter = _converterFactory.create();

    _subject.add(ConverterEvent(converter: converter));
  }

  Future<void> dispose() async {
    await _subject.close();
  }
}
