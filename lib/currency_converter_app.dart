import 'package:currency_converter/converter/converter_factory.dart';
import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/ui/currency_conversion_page.dart';
import 'package:flutter/material.dart';

class CurrencyConverterApp extends StatelessWidget {
  final CurrencyRepository repository;
  final ConverterFactory factory;

  const CurrencyConverterApp({
    Key? key,
    required this.factory,
    required this.repository
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConversionPage(
        component: CurrencyConverterComponent(
            factory: factory,
            repository: repository
        ),
        title: 'Currency Converter',
      ),
    );
  }
}
