import 'dart:async';

import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/converter/converter_event.dart';
import 'package:currency_converter/converter/data/remote_data_source.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyConverterComponent {
  CurrencyConverterComponent({repository, converter})
      : _repository = repository ?? CurrencyRepository(remoteDataSource: RemoteDataSource());

  Stream<ConverterEvent> get currencyEventObservable => _subject.stream;

  final CurrencyRepository _repository;
  final BehaviorSubject<ConverterEvent> _subject = BehaviorSubject();

  Future<void> selectCurrency({required String code}) async {
    final currency = await _repository.getCurrencyForCode(code);
    final currencyList = await _repository.getCurrencies();

    currencyList.removeWhere((element) => element.code == code);

    CurrencyConverter converter = CurrencyConverter(currency: currency, targetCurrencyList: currencyList);

    _subject.add(ConverterEvent(converter: converter));
  }

  Future<void> dispose() async {
    await _subject.close();
  }
}
