class CurrencySymbol {
  CurrencySymbol(
      {required this.code,
      required this.description});

  final String code;
  final String description;

  CurrencySymbol.dollar()
      : code = 'USD',
        description = 'United States Dollar';

  CurrencySymbol.euro()
      : code = 'EUR',
        description = 'Euro';

  CurrencySymbol.yen()
      : code = 'JPY',
        description = 'Japanese Yen';

  @override
  bool operator ==(Object other) {
    if(other is! CurrencySymbol) {
      return false;
    }

    return other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}
