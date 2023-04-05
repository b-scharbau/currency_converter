import 'package:currency_converter/ui/model/currency.dart';
import 'package:currency_converter/ui/model/conversion_row.dart';
import 'package:collection/collection.dart';

class ConversionTable {
  ConversionTable(
      {required this.from, required this.rowData, required this.to});

  final Currency from;
  final List<ConversionRow> rowData;
  final Currency to;

  bool equals(ConversionTable other) {
    final rowEquality = const ListEquality().equals(other.rowData, rowData);

    return (other.from.code == from.code &&
        other.to.code == to.code &&
        rowEquality);
  }
}
