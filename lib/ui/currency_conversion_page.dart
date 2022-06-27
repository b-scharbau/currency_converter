import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/model/conversion_currency_event.dart';
import 'package:currency_converter/converter/model/conversion_event.dart';
import 'package:currency_converter/converter/model/conversion_result_event.dart';
import 'package:currency_converter/converter/model/conversion_table_event.dart';
import 'package:currency_converter/ui/conversion_table_widget.dart';
import 'package:currency_converter/ui/model/conversion_table.dart';
import 'package:currency_converter/ui/model/currency_symbol.dart';
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
  final _amountController = TextEditingController();
  double _conversionAmount = 0.0;
  late ConversionTable _conversionTable = ConversionTable(to: _targetCurrency, from: _activeCurrency, rowData: []);
  final _formKey = GlobalKey<FormState>();
  Function()? _selectActiveCurrency;
  Function()? _selectTargetCurrency;
  CurrencySymbol _activeCurrency = CurrencySymbol.euro();
  CurrencySymbol _targetCurrency = CurrencySymbol.yen();

  @override
  void dispose() {
    _amountController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.component.generateConversionTable(from: _activeCurrency, to: _targetCurrency);
    widget.component.getAvailableCurrencies();

    widget.component.currencyEventObservable.listen((event) {
      switch(event.type) {
        case ConversionEventType.conversionCurrencyEvent:
          _selectActiveCurrency = () async {
            final newCurrency = await _showCurrencySelectDialog(event as ConversionCurrencyEvent);
            if(newCurrency != null) {
              setState(() {
                _activeCurrency = newCurrency;
                widget.component.generateConversionTable(from: _activeCurrency, to: _targetCurrency);
              });
            }
          };
          _selectTargetCurrency = () async {
            final newCurrency = await _showCurrencySelectDialog(event as ConversionCurrencyEvent);
            if(newCurrency != null) {
              setState(() {
                _targetCurrency = newCurrency;
                widget.component.generateConversionTable(from: _activeCurrency, to: _targetCurrency);
              });
            }
          };
          break;
        case ConversionEventType.conversionResultEvent:
          _updateConversionResult((event as ConversionResultEvent).convertedAmount);
          break;
        case ConversionEventType.conversionTableEvent:
          _updateConversionTable((event as ConversionTableEvent).conversionTable);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final format =
    NumberFormat.currency(locale: locale.toLanguageTag(), symbol: _targetCurrency.code);

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Value:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _amountController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Amount',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some value';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: _selectActiveCurrency,
                            child: Text(_activeCurrency.code)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final amount = double.parse(_amountController.text);
                          widget.component.convert(
                              from: _activeCurrency.code, to: _targetCurrency.code, amount: amount);
                        }
                      },
                      child: const Text('convert')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Converted value: ${format.format(_conversionAmount)}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  ElevatedButton(
                      onPressed: _selectTargetCurrency,
                      child: Text(_targetCurrency.code)),
                ],
              ),
            ),
            ConversionTableWidget(data: _conversionTable)
          ],
        ),
      ),
    );
  }

  Future<CurrencySymbol?> _showCurrencySelectDialog(ConversionCurrencyEvent event) async {
    return showDialog<CurrencySymbol>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select currency'),
            children: <Widget>[
              ...(event).currencyList.map((
                  currency) =>
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, currency);
                    },
                    child: Text('${currency.description} (${currency.code})'),
                  ))
            ],
          );
        });
  }

  void _updateConversionResult(double convertedAmount) {
    setState(() {
      _conversionAmount = convertedAmount;
    });
  }

  void _updateConversionTable(ConversionTable conversionTable) {
    setState(() {
      _conversionTable = conversionTable;
    });
  }
}
