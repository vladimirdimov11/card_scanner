// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:card_scanner/base/app/config/environment_config.dart';
import 'package:card_scanner/base/common_services/card_service.dart';
import 'package:card_scanner/base/repositories/card_repository.dart';
import 'package:card_scanner/feature_scanner/blocs/scanner_bloc.dart';
import 'package:card_scanner/feature_scanner/services/card_validation_service.dart';
import 'package:card_scanner/lib_card_scanner/card_scanner_service.dart';
import 'package:card_scanner/lib_router/blocs/router_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_bloc_test/rx_bloc_test.dart';

import '../../base/common_blocs/router_bloc_mock.dart';
import '../../stubs.dart';
import 'scanner_bloc_test.mocks.dart';

@GenerateMocks([
  CardRepository,
  CardScannerService,
  CardValidationService,
])
void main() {
  late MockCardRepository repo;
  late MockCardScannerService cardScannerService;
  late MockCardValidationService cardValidationService;
  late RouterBlocType routerBlocType;

  ScannerBloc scannerBloc() => ScannerBloc(
        CardService(repo, EnvironmentConfig.development),
        cardValidationService,
        cardScannerService,
        routerBlocType,
      );

  setUp(() {
    repo = MockCardRepository();
    cardScannerService = MockCardScannerService();
    cardValidationService = MockCardValidationService();
    routerBlocType = routerBlocMockFactory();
  });

  group('ScannerBloc tests', () {
    rxBlocTest<ScannerBlocType, bool>(
      'scanner_bloc - is submitted',
      build: () async {
        when(repo.addCard(cardModel: Stubs.cardRequestModel))
            .thenAnswer((_) async => Future.value());
        return scannerBloc();
      },
      act: (bloc) async {
        bloc.events.submitCard();
      },
      state: (bloc) => bloc.states.isSubmitted,
      expect: [true],
    );

    rxBlocTest<ScannerBlocType, bool>(
      'scanner_bloc - is loading',
      build: () async {
        when(repo.addCard(cardModel: Stubs.cardRequestModel))
            .thenAnswer((_) async => Future.value());
        return scannerBloc();
      },
      act: (bloc) async {
        bloc.events.submitCard();
      },
      state: (bloc) => bloc.states.isLoading,
      expect: [false, true],
    );
  });
}
