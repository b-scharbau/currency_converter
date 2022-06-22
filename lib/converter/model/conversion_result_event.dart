import 'package:currency_converter/converter/model/conversion_event.dart';

class ConversionResultEvent extends ConversionEvent {
  ConversionResultEvent({required this.convertedAmount}) : super(type: ConverterEventType.conversionResultEvent);
  
  double convertedAmount;
}