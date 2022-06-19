import 'dart:async';

import 'package:currency_converter/converter/currency_repository.dart';

class CurrencyConverterComponent {
  final StreamController<double> controller = StreamController();
  late final Stream<double> currencyValueObservable = controller.stream.asBroadcastStream();
  final CurrencyRepository _repository;

  CurrencyConverterComponent({repository}) : _repository = repository ?? CurrencyRepository();

  Future<void> convert({required String from, required String to, required double amount}) async {
    final currency = await _repository.getCurrencyForCode(from);
    final result = currency.convert(to: to, amount: amount);

    controller.sink.add(result);
  }

  Future<void> dispose() async {
    await controller.close();
  }
}