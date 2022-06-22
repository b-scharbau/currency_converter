enum ConverterEventType { conversionResultEvent, conversionTableEvent  }

abstract class ConversionEvent {
  ConversionEvent({required this.type});

  ConverterEventType type;
}