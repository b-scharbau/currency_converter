import 'package:currency_converter/ui/model/currency_symbol.dart';

class ConversionTable {
  ConversionTable({required this.from, required this.rowData, required this.to});

  final CurrencySymbol from;
  final List<ConversionRow> rowData;
  final CurrencySymbol to;
}

class ConversionRow {
  ConversionRow({required this.left, required this.right});

  final double left;
  final double right;
}