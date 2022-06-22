import 'package:currency_converter/converter/conversion_table_component.dart';
import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/model/currency.dart';
import 'package:currency_converter/ui/currency_conversion_page.dart';
import 'package:flutter/material.dart';

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CurrencyConverter converter = CurrencyConverter(currency: Currency.euro());

    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConversionPage(
        component: CurrencyConverterComponent(converter: converter),
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}
