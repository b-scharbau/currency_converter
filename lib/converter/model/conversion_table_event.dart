import 'package:currency_converter/converter/model/conversion_event.dart';
import 'package:currency_converter/ui/conversion_table_widget.dart';
import 'package:currency_converter/ui/model/conversion_table.dart';

class ConversionTableEvent extends ConversionEvent {
  ConversionTableEvent({required this.conversionTable})
      : super(type: ConverterEventType.conversionTableEvent);

  ConversionTable conversionTable;
}
