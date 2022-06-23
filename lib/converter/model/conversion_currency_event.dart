import 'package:currency_converter/converter/model/conversion_event.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';

class ConversionCurrencyEvent extends ConversionEvent {
  List<CurrencySymbol> currencyList;

  ConversionCurrencyEvent({required this.currencyList})
      : super(type: ConverterEventType.conversionCurrencyEvent);
}
