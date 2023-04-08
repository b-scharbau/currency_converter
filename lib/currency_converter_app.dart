import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/model/currency.dart';
import 'package:currency_converter/ui/currency_conversion_page.dart';
import 'package:flutter/material.dart';

class CurrencyConverterApp extends StatelessWidget {
  final CurrencyRepository repository;

  CurrencyConverterApp({Key? key, required this.repository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConversionPage(
        component: CurrencyConverterComponent(repository: repository),
        title: 'Currency Converter',
      ),
    );
  }
}
