import 'package:currency_converter/converter/model/conversion_event.dart';

class ConversionResultEvent extends ConversionEvent {
  ConversionResultEvent({required this.convertedAmount}) : super(type: ConversionEventType.conversionResultEvent);
  
  double convertedAmount;
}