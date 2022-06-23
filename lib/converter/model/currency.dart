class Currency {
  Currency(
      {required this.code,
      required this.date,
      required this.description,
      required this.exchangeRates});

  Currency.dollar()
      : code = 'USD',
        date = DateTime(2022, 6, 17),
        description = 'United States Dollar',
        exchangeRates = {'EUR': 0.95215, 'JPY': 134.409499, 'USD': 1.0};

  Currency.euro()
      : code = 'EUR',
        date = DateTime(2022, 6, 17),
        description = 'Euro',
        exchangeRates = {'EUR': 1.0, 'JPY': 140.881056, 'USD': 1.051481};

  Currency.yen()
      : code = 'JPY',
        date = DateTime(2022, 6, 17),
        description = 'Japanese Yen',
        exchangeRates = {'EUR': 0.007086, 'JPY':1.0, 'USD': 0.00744};

  final String code;
  final DateTime date;
  final String description;
  final Map<String, double> exchangeRates;
}
