import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/model/currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversionTableWidget extends StatelessWidget {
  const ConversionTableWidget({Key? key, required this.converter, required this.from, required this.to}) : super(key: key);

  final Currency from;
  final Currency to;
  final CurrencyConverter converter;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);

    final fromFormat =
    NumberFormat.currency(locale: locale.toLanguageTag(), symbol: from.code);
    final toFormat =
    NumberFormat.currency(locale: locale.toLanguageTag(), symbol: to.code);
    final dateFormat = DateFormat('dd.MM.y', locale.toLanguageTag());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(from.code),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(to.code),
                    )
                  ]
              ),
              ...[1.0, 10.0, 100.0, 1000.0].map((value) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(fromFormat.format(value)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(toFormat.format(converter.convert(amount: value, to: to.code))),
                      )
                    ]
                )
              ).toList(),
            ],
          ),
        ),
        Text('Exchange rate from ${dateFormat.format(converter.currency.date)}')
      ],
    );
  }
}