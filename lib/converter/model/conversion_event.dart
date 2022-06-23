enum ConverterEventType { conversionCurrencyEvent, conversionResultEvent, conversionTableEvent  }

abstract class ConversionEvent {
  ConversionEvent({required this.type});

  ConverterEventType type;
}