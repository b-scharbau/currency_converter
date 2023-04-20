import 'dart:async';

import 'package:currency_converter/converter/converter_factory.dart';
import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/converter/converter_event.dart';
import 'package:rxdart/rxdart.dart';

import 'loading_event.dart';

class CurrencyConverterComponent {
  CurrencyConverterComponent({
    required CurrencyRepository repository,
    required ConverterFactory factory
  })
      : _repository = repository,
        _converterFactory = factory;

  final CurrencyRepository _repository;
  final ConverterFactory _converterFactory;
  final BehaviorSubject<ConverterEvent> _subject = BehaviorSubject();
  final BehaviorSubject<LoadingEvent> _loadingSubject = BehaviorSubject();

  Stream<ConverterEvent> get currencyEventObservable => _subject.stream;
  Stream<LoadingEvent> get loadingEventObservable => _loadingSubject.stream;

  Future<void> selectCurrency({required String code}) async {
    _loadingSubject.sink.add(LoadingEvent(status: LoadingStatus.loading));

    final currencyList = await _repository.getCurrencies();
    await for (final currency in _repository.getCurrencyForCode(code)) {
      currencyList.removeWhere((element) => element.code == code);

      _converterFactory.currency = currency;
      _converterFactory.targetCurrencyList = currencyList;

      CurrencyConverter converter = _converterFactory.create();

      _subject.add(ConverterEvent(converter: converter));
    }

    _loadingSubject.sink.add(LoadingEvent(status: LoadingStatus.finished));
  }

  Future<void> dispose() async {
    await _subject.close();
  }
}
