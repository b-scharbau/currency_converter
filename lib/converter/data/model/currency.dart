import 'package:currency_converter/converter/data/model/exchange_rate.dart';

class Currency {
  Currency(
      {required this.code,
      required this.date,
      required this.description,
      required this.exchangeRates});

  final String code;
  final DateTime date;
  final String description;
  final List<ExchangeRate> exchangeRates;

  Currency.dollar()
      : code = 'USD',
        date = DateTime(2022, 6, 17),
        description = 'United States Dollar',
        exchangeRates = [
          ExchangeRate(
              other: Currency(
                  code: 'EUR',
                  date: DateTime(2022, 6, 17),
                  description: 'Euro',
                  exchangeRates: []),
              rate: 0.95215),
          ExchangeRate(
              other: Currency(
                  code: 'JPY',
                  date: DateTime(2022, 6, 17),
                  description: 'Japanese Yen',
                  exchangeRates: []),
              rate: 134.409499),
          ExchangeRate(
              other: Currency(
                  code: 'USD',
                  date: DateTime(2022, 6, 17),
                  description: 'United States Dollar',
                  exchangeRates: []),
              rate: 1.0)
        ];

  Currency.euro()
      : code = 'EUR',
        date = DateTime(2022, 6, 17),
        description = 'Euro',
        exchangeRates = [
          ExchangeRate(
              other: Currency(
                  code: 'EUR',
                  date: DateTime(2022, 6, 17),
                  description: 'Euro',
                  exchangeRates: []),
              rate: 1.0),
          ExchangeRate(
              other: Currency(
                  code: 'JPY',
                  date: DateTime(2022, 6, 17),
                  description: 'Japanese Yen',
                  exchangeRates: []),
              rate: 140.881056),
          ExchangeRate(
              other: Currency(
                  code: 'USD',
                  date: DateTime(2022, 6, 17),
                  description: 'United States Dollar',
                  exchangeRates: []),
              rate: 1.051481)
        ];

  Currency.yen()
      : code = 'JPY',
        date = DateTime(2022, 6, 17),
        description = 'Japanese Yen',
        exchangeRates = [
          ExchangeRate(
              other: Currency(
                  code: 'EUR',
                  date: DateTime(2022, 6, 17),
                  description: 'Euro',
                  exchangeRates: []),
              rate: 0.007086),
          ExchangeRate(
              other: Currency(
                  code: 'JPY',
                  date: DateTime(2022, 6, 17),
                  description: 'Japanese Yen',
                  exchangeRates: []),
              rate: 1.0),
          ExchangeRate(
              other: Currency(
                  code: 'USD',
                  date: DateTime(2022, 6, 17),
                  description: 'United States Dollar',
                  exchangeRates: []),
              rate: 0.00744)
        ];
}
