// Mocks generated by Mockito 5.2.0 from annotations
// in currency_converter/test/converter/currency_converter_component_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:currency_converter/converter/currency_repository.dart' as _i3;
import 'package:currency_converter/converter/model/currency.dart' as _i2;
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

class _FakeCurrency_0 extends _i1.Fake implements _i2.Currency {}

/// A class which mocks [CurrencyRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrencyRepository extends _i1.Mock
    implements _i3.CurrencyRepository {
  MockCurrencyRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Currency> getCurrencyForCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#getCurrencyForCode, [code]),
              returnValue: Future<_i2.Currency>.value(_FakeCurrency_0()))
          as _i4.Future<_i2.Currency>);
}