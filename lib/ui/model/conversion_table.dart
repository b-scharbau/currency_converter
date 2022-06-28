import 'package:currency_converter/ui/model/conversion_row.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';
import 'package:collection/collection.dart';

class ConversionTable {
  ConversionTable(
      {required this.from, required this.rowData, required this.to});

  final CurrencySymbol from;
  final List<ConversionRow> rowData;
  final CurrencySymbol to;

  bool equals(ConversionTable other) {
    final rowEquality = ListEquality().equals(other.rowData, rowData);

    return (other.from.code == from.code &&
        other.to.code == to.code &&
        rowEquality);
  }
}
