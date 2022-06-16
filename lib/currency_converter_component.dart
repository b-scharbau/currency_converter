import 'dart:async';

class CurrencyConverterComponent {
  StreamController<double> controller = StreamController();
  late Stream<double> currencyValueObservable = controller.stream.asBroadcastStream();

  void convert(double value) {
    controller.sink.add(value * 140.42133);
  }

  Future<void> dispose() async {
    await controller.close();
  }
}