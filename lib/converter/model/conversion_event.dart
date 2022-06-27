enum ConversionEventType { conversionCurrencyEvent, conversionResultEvent, conversionTableEvent  }

abstract class ConversionEvent {
  ConversionEvent({required this.type});

  ConversionEventType type;
}