import 'package:currency_converter/ui/model/conversion_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversionTableWidget extends StatelessWidget {
  const ConversionTableWidget({Key? key, required this.data}) : super(key: key);

  final ConversionTable data;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);

    final fromFormat =
    NumberFormat.currency(locale: locale.toLanguageTag(), symbol: data.from.code);
    final toFormat =
    NumberFormat.currency(locale: locale.toLanguageTag(), symbol: data.to.code);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data.from.code),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data.to.code),
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