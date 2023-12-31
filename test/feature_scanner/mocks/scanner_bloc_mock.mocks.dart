// Mocks generated by Mockito 5.4.2 from annotations
// in card_scanner/test/feature_scanner/mocks/scanner_bloc_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:card_scanner/base/models/errors/error_model.dart' as _i5;
import 'package:card_scanner/feature_scanner/blocs/scanner_bloc.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/rxdart.dart' as _i2;

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

class _FakeConnectableStream_0<T> extends _i1.SmartFake
    implements _i2.ConnectableStream<T> {
  _FakeConnectableStream_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeScannerBlocEvents_1 extends _i1.SmartFake
    implements _i3.ScannerBlocEvents {
  _FakeScannerBlocEvents_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeScannerBlocStates_2 extends _i1.SmartFake
    implements _i3.ScannerBlocStates {
  _FakeScannerBlocStates_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ScannerBlocEvents].
///
/// See the documentation for Mockito's code generation for more information.
class MockScannerBlocEvents extends _i1.Mock implements _i3.ScannerBlocEvents {
  MockScannerBlocEvents() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void setCardNumber(String? cardNumber) => super.noSuchMethod(
        Invocation.method(
          #setCardNumber,
          [cardNumber],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setCardHolder(String? cardHolder) => super.noSuchMethod(
        Invocation.method(
          #setCardHolder,
          [cardHolder],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setCardExpDate(String? cardExpDate) => super.noSuchMethod(
        Invocation.method(
          #setCardExpDate,
          [cardExpDate],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setCardCVV(String? cardCVV) => super.noSuchMethod(
        Invocation.method(
          #setCardCVV,
          [cardCVV],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void submitCard() => super.noSuchMethod(
        Invocation.method(
          #submitCard,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void scanCard() => super.noSuchMethod(
        Invocation.method(
          #scanCard,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ScannerBlocStates].
///
/// See the documentation for Mockito's code generation for more information.
class MockScannerBlocStates extends _i1.Mock implements _i3.ScannerBlocStates {
  MockScannerBlocStates() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ConnectableStream<String> get cardNumber => (super.noSuchMethod(
        Invocation.getter(#cardNumber),
        returnValue: _FakeConnectableStream_0<String>(
          this,
          Invocation.getter(#cardNumber),
        ),
      ) as _i2.ConnectableStream<String>);
  @override
  _i2.ConnectableStream<String> get cardHolder => (super.noSuchMethod(
        Invocation.getter(#cardHolder),
        returnValue: _FakeConnectableStream_0<String>(
          this,
          Invocation.getter(#cardHolder),
        ),
      ) as _i2.ConnectableStream<String>);
  @override
  _i2.ConnectableStream<String> get cardExpirationDate => (super.noSuchMethod(
        Invocation.getter(#cardExpirationDate),
        returnValue: _FakeConnectableStream_0<String>(
          this,
          Invocation.getter(#cardExpirationDate),
        ),
      ) as _i2.ConnectableStream<String>);
  @override
  _i2.ConnectableStream<String> get cardCVV => (super.noSuchMethod(
        Invocation.getter(#cardCVV),
        returnValue: _FakeConnectableStream_0<String>(
          this,
          Invocation.getter(#cardCVV),
        ),
      ) as _i2.ConnectableStream<String>);
  @override
  _i2.ConnectableStream<bool> get isSubmitted => (super.noSuchMethod(
        Invocation.getter(#isSubmitted),
        returnValue: _FakeConnectableStream_0<bool>(
          this,
          Invocation.getter(#isSubmitted),
        ),
      ) as _i2.ConnectableStream<bool>);
  @override
  _i4.Stream<bool> get showErrors => (super.noSuchMethod(
        Invocation.getter(#showErrors),
        returnValue: _i4.Stream<bool>.empty(),
      ) as _i4.Stream<bool>);
  @override
  _i4.Stream<bool> get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: _i4.Stream<bool>.empty(),
      ) as _i4.Stream<bool>);
  @override
  _i4.Stream<_i5.ErrorModel> get errors => (super.noSuchMethod(
        Invocation.getter(#errors),
        returnValue: _i4.Stream<_i5.ErrorModel>.empty(),
      ) as _i4.Stream<_i5.ErrorModel>);
}

/// A class which mocks [ScannerBlocType].
///
/// See the documentation for Mockito's code generation for more information.
class MockScannerBlocType extends _i1.Mock implements _i3.ScannerBlocType {
  MockScannerBlocType() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.ScannerBlocEvents get events => (super.noSuchMethod(
        Invocation.getter(#events),
        returnValue: _FakeScannerBlocEvents_1(
          this,
          Invocation.getter(#events),
        ),
      ) as _i3.ScannerBlocEvents);
  @override
  _i3.ScannerBlocStates get states => (super.noSuchMethod(
        Invocation.getter(#states),
        returnValue: _FakeScannerBlocStates_2(
          this,
          Invocation.getter(#states),
        ),
      ) as _i3.ScannerBlocStates);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
