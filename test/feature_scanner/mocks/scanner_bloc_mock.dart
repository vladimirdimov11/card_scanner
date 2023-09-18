import 'package:card_scanner/base/models/errors/error_model.dart';
import 'package:card_scanner/feature_scanner/blocs/scanner_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../stubs.dart';
import 'scanner_bloc_mock.mocks.dart';

@GenerateMocks([
  ScannerBlocEvents,
  ScannerBlocStates,
  ScannerBlocType,
])
ScannerBlocType scannerBlocMockFactory({
  ErrorModel? error,
  bool? isLoading,
}) {
  final scannerBloc = MockScannerBlocType();
  final eventsMock = MockScannerBlocEvents();
  final statesMock = MockScannerBlocStates();

  when(scannerBloc.events).thenReturn(eventsMock);
  when(scannerBloc.states).thenReturn(statesMock);

  when(statesMock.cardNumber).thenAnswer(
    (_) => Stream.value(Stubs.cardNumber).publish(),
  );
  when(statesMock.cardHolder).thenAnswer(
    (_) => Stream.value(Stubs.cardHolder).publish(),
  );
  when(statesMock.cardExpirationDate).thenAnswer(
    (_) => Stream.value(Stubs.cardExpDate).publish(),
  );
  when(statesMock.cardCVV).thenAnswer(
    (_) => Stream.value(Stubs.cardCVV).publish(),
  );

  when(statesMock.showErrors).thenAnswer(
    (_) => Stream.value(false),
  );

  when(statesMock.isSubmitted).thenAnswer(
    (_) => Stream.value(false).publish(),
  );

  when(statesMock.errors).thenAnswer(
    (_) => error != null ? Stream.value(error) : const Stream.empty(),
  );

  when(statesMock.isLoading).thenAnswer(
    (_) => isLoading != null ? Stream.value(isLoading) : const Stream.empty(),
  );

  return scannerBloc;
}
