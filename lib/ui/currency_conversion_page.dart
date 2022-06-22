import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/model/conversion_event.dart';
import 'package:currency_converter/converter/model/conversion_result_event.dart';
import 'package:currency_converter/converter/model/conversion_table_event.dart';
import 'package:currency_converter/ui/conversion_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyConversionPage extends StatefulWidget {
  const CurrencyConversionPage(
      {Key? key,
      required this.title,
      required this.component})
      : super(key: key);

  final CurrencyConverterComponent component;
  final String title;

  @override
  State<CurrencyConversionPage> createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  double conversionAmount = 0.0;
  ConversionData conversionTable = ConversionData(to: 'JPY', from: 'EUR', rowData: []);

  @override
  void dispose() {
    amountController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.component.generateTable(from: 'EUR', to: 'JPY');

    widget.component.currencyValueObservable.listen((event) {
      switch(event.type) {
        case ConverterEventType.conversionResultEvent:
          _updateConversionResult((event as ConversionResultEvent).convertedAmount);
          break;
        case ConverterEventType.conversionTableEvent:
          _updateConversionTable((event as ConversionTableEvent).conversionTable);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final format =
    NumberFormat.currency(locale: "ja_JP", symbol: '¥');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Value to convert:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: amountController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Amount',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final amount = double.parse(amountController.text);
                          widget.component.convert(
                              from: 'EUR', to: 'JPY', amount: amount);
                        }
                      },
                      child: const Text('convert')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Converted value: ${format.format(conversionAmount)}',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            ConversionTable(data: conversionTable)
          ],
        ),
      ),
    );
  }

  void _updateConversionResult(double convertedAmount) {
    setState(() {
      conversionAmount = convertedAmount;
    });
  }

  void _updateConversionTable(ConversionData conversionTable) {
    setState(() {
      this.conversionTable = conversionTable;
    });
  }
}
