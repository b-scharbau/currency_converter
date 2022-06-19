import 'package:currency_converter/converter/currency_converter_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyConversionPage extends StatefulWidget {
  const CurrencyConversionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CurrencyConversionPage> createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  final CurrencyConverterComponent component = CurrencyConverterComponent();
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          component.convert(from: 'EUR', to: 'JPY', amount: amount);
                        }
                      },
                      child: const Text('convert')),
                ],
              ),
            ),
            StreamBuilder<double>(
              stream: component.currencyValueObservable,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  final format = NumberFormat.currency(locale: "ja_JP",symbol: '¥');
                  final value = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Converted value: ${format.format(value)}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  );
                }
                return const Text('Enter value to convert',
                style: TextStyle(fontSize: 16.0),);
              }
            ),
          ],
        ),
      ),
    );
  }
}
