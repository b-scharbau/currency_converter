import 'package:currency_converter/converter/currency_converter.dart';

enum LoadingStatus { loading, error, finished }

class LoadingEvent {
  LoadingStatus status;

  LoadingEvent({required this.status});
}