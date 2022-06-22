import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversionTable extends StatelessWidget {
  const ConversionTable({Key? key, required this.data}) : super(key: key);

  final ConversionData data;

  @override
  Widget build(BuildContext context) {
    final fromFormat =
    NumberFormat.currency(locale: "de_DE", symbol: '€');
    final toFormat =
    NumberFormat.currency(locale: "ja_JP", symbol: '¥');

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          const TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('EUR'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('JPY'),
                )
              ]
          ),
          ...data.rowData.map((e) => TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(fromFormat.format(e.left)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(toFormat.format(e.right)),
              )
            ]
        )).toList()
        ],
      ),
    );
  }
}

class ConversionData {
  ConversionData({required this.from, required this.rowData, required this.to});

  final String from;
  final List<ConversionRow> rowData;
  final String to;
}

class ConversionRow {
  ConversionRow({required this.left, required this.right});

  final double left;
  final double right;
}