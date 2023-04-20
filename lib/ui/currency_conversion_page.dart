import 'package:currency_converter/converter/currency_converter.dart';
import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:currency_converter/converter/loading_event.dart';
import 'package:currency_converter/model/currency.dart';
import 'package:currency_converter/ui/conversion_table_widget.dart';
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
  final _formKey = GlobalKey<FormState>();
  Function()? _selectActiveCurrency;
  Function()? _selectTargetCurrency;
  Currency _activeCurrency = Currency.euro();
  Currency _targetCurrency = Currency.yen();
  CurrencyConverter? _converter;

  @override
  void dispose() {
    _amountController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.component.selectCurrency(code: _activeCurrency.code);

    widget.component.currencyEventObservable.listen((event) {
      setState(() {
        _converter = event.converter;

        _selectTargetCurrency = () async {
          final newCurrency = await _showCurrencySelectDialog(_converter!.targetCurrencyList);

          if(newCurrency != null) {
            setState(() {
              _targetCurrency = newCurrency;
            });
          }
        };

        _selectActiveCurrency = () async {
          final newCurrency = await _showCurrencySelectDialog(_converter!.targetCurrencyList);

          if (newCurrency != null) {
            if (newCurrency.code == _targetCurrency.code) {
              _targetCurrency = _activeCurrency;
            }
            _activeCurrency = newCurrency;
            widget.component.selectCurrency(code: _activeCurrency.code);
          }
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final format =
    NumberFormat.currency(locale: locale.toLanguageTag(), symbol: _targetCurrency.code);

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<LoadingEvent>(
            stream: widget.component.loadingEventObservable,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final event = snapshot.data;

                switch(event!.status) {
                  case LoadingStatus.loading:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.title),
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    );
                  default:
                    return Text(widget.title);
                }
              }
              return Text(widget.title);
            }
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _conversionAmount = double.parse(_amountController.text);
                                    });
                                  }
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
                            setState(() {
                              _conversionAmount = double.parse(_amountController.text);
                            });
                          }
                        },
                        child: const Text('Convert')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Converted value: ${format.format(_convert(_conversionAmount))}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    ElevatedButton(
                        onPressed: _selectTargetCurrency,
                        child: Text(_targetCurrency.code)),
                  ],
                ),
              ),
              Builder(
                builder: (BuildContext context) {
                  if (_converter == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        ConversionTableWidget(converter: _converter!, from: _activeCurrency, to: _targetCurrency),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Currency?> _showCurrencySelectDialog(List<Currency> currencyList) async {
    return showDialog<Currency>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select currency'),
            children: <Widget>[
              ...currencyList.map((
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

  double _convert(double conversionAmount) {
    if (_converter == null) {
      return 0.0;
    }
    return _converter!.convert(
        to: _targetCurrency.code, amount: conversionAmount);
  }
}
