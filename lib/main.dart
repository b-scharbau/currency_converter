import 'package:currency_converter/converter/data/currency_repository.dart';
import 'package:currency_converter/converter/data/local_data_source.dart';
import 'package:currency_converter/converter/data/model/currency.dart';
import 'package:currency_converter/converter/data/remote_data_source.dart';
import 'package:currency_converter/currency_converter_app.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
    join(await getDatabasesPath(), 'currency.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE currencies(code TEXT PRIMARY KEY, description TEXT, date INTEGER)',
      );
      await db.execute(
        'CREATE TABLE exchange_rates(currency TEXT, other TEXT, rate REAL, PRIMARY KEY (currency, other))',
      );
      await db.insert('currencies', Currency.dollar().toMap());
      await db.insert('currencies', Currency.euro().toMap());
      await db.insert('currencies', Currency.yen().toMap());

      await db.insert('exchange_rates', { 'currency': 'EUR', 'other': 'JPY', 'rate': 140.881056});
      await db.insert('exchange_rates', { 'currency': 'EUR', 'other': 'USD', 'rate': 1.051481});

      await db.insert('exchange_rates', { 'currency': 'JPY', 'other': 'EUR', 'rate': 0.007086});
      await db.insert('exchange_rates', { 'currency': 'JPY', 'other': 'USD', 'rate': 0.00744});

      await db.insert('exchange_rates', { 'currency': 'USD', 'other': 'JPY', 'rate': 134.409499});
      await db.insert('exchange_rates', { 'currency': 'USD', 'other': 'EUR', 'rate': 0.95215});
    },
    version: 1,
  );

  final localDataSource = LocalDataSource(db: database);
  final remoteDataSource = RemoteDataSource();

  final repository = CurrencyRepository(localDataSource: localDataSource, remoteDataSource: remoteDataSource);

  runApp(CurrencyConverterApp(repository: repository));
}
