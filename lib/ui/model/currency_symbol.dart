class CurrencySymbol {
  CurrencySymbol(
      {required this.code,
      required this.description,
      required this.locale,
      required this.symbol});

  final String code;
  final String description;
  final String locale;
  final String symbol;

  CurrencySymbol.dollar()
      : code = 'USD',
        description = 'United States Dollar',
        locale = 'en_US',
        symbol = '\$';

  CurrencySymbol.euro()
      : code = 'EUR',
        description = 'Euro',
        locale = 'de_DE',
        symbol = '€';

  CurrencySymbol.yen()
      : code = 'JPY',
        description = 'Japanese Yen',
        locale = 'ja_JP',
        symbol = '¥';
}
