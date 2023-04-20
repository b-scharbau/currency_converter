// Mocks generated by Mockito 5.3.2 from annotations
// in currency_converter/test/integration/converter/currency_converter_component_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:currency_converter/converter/data/currency_repository.dart'
    as _i4;
import 'package:currency_converter/converter/data/data_source.dart' as _i2;
import 'package:currency_converter/model/currency.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDataSource_0 extends _i1.SmartFake implements _i2.DataSource {
  _FakeDataSource_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCurrency_1 extends _i1.SmartFake implements _i3.Currency {
  _FakeCurrency_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CurrencyRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrencyRepository extends _i1.Mock
    implements _i4.CurrencyRepository {
  MockCurrencyRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DataSource get localDataSource => (super.noSuchMethod(
        Invocation.getter(#localDataSource),
        returnValue: _FakeDataSource_0(
          this,
          Invocation.getter(#localDataSource),
        ),
      ) as _i2.DataSource);
  @override
  _i2.DataSource get remoteDataSource => (super.noSuchMethod(
        Invocation.getter(#remoteDataSource),
        returnValue: _FakeDataSource_0(
          this,
          Invocation.getter(#remoteDataSource),
        ),
      ) as _i2.DataSource);
  @override
  _i5.Future<_i3.Currency> getCurrencyForCode(String? code) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrencyForCode,
          [code],
        ),
        returnValue: _i5.Future<_i3.Currency>.value(_FakeCurrency_1(
          this,
          Invocation.method(
            #getCurrencyForCode,
            [code],
          ),
        )),
      ) as _i5.Future<_i3.Currency>);
  @override
  _i5.Future<List<_i3.Currency>> getCurrencies() => (super.noSuchMethod(
        Invocation.method(
          #getCurrencies,
          [],
        ),
        returnValue: _i5.Future<List<_i3.Currency>>.value(<_i3.Currency>[]),
      ) as _i5.Future<List<_i3.Currency>>);
}