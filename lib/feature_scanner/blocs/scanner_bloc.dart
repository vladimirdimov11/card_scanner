// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/common_services/card_service.dart';
import '../../base/extensions/error_model_extensions.dart';
import '../../base/models/errors/error_model.dart';
import '../../base/models/request_model/card_request_model.dart';
import '../../lib_card_scanner/card_scanner_service.dart';
import '../../lib_router/blocs/router_bloc.dart';
import '../../lib_router/router.dart';
import '../services/card_validation_service.dart';

part 'scanner_bloc.rxb.g.dart';

part 'scanner_bloc_extensions.dart';

/// A contract class containing all events of the ScannerBloC.
abstract class ScannerBlocEvents {
  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: '')
  void setCardNumber(String cardNumber);

  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: '')
  void setCardHolder(String cardHolder);

  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: '')
  void setCardExpDate(String cardExpDate);

  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: '')
  void setCardCVV(String cardCVV);

  void submitCard();

  void scanCard();
}

/// A contract class containing all states of the ScannerBloC.
abstract class ScannerBlocStates {
  /// The currently entered card number state
  ConnectableStream<String> get cardNumber;

  /// The currently entered card holder state
  ConnectableStream<String> get cardHolder;

  /// The currently entered card expiration date state
  ConnectableStream<String> get cardExpirationDate;

  /// The currently entered card cvv state
  ConnectableStream<String> get cardCVV;

  /// State indicating whether the card is submitted successfully
  ConnectableStream<bool> get isSubmitted;

  /// The state indicating whether we show errors to the user
  Stream<bool> get showErrors;

  /// The loading state
  Stream<bool> get isLoading;

  /// The error state
  Stream<ErrorModel> get errors;
}

@RxBloc()
class ScannerBloc extends $ScannerBloc {
  ScannerBloc(
    this._cardService,
    this._cardValidationService,
    this._cardScannerService,
    this._navigationBloc,
  ) {
    cardNumber.connect().addTo(_compositeSubscription);
    cardHolder.connect().addTo(_compositeSubscription);
    cardExpirationDate.connect().addTo(_compositeSubscription);
    cardCVV.connect().addTo(_compositeSubscription);
    isSubmitted.connect().addTo(_compositeSubscription);
    _$scanCardEvent
        .switchMap((_) => _cardScannerService.scanCard().asResultStream())
        .whereSuccess()
        .where((args) => args != null)
        .map((cardDetails) {
          setCardNumber(_toSpaceSeparatedNumber(cardDetails!.cardNumber));
          setCardHolder(cardDetails.cardHolderName);
          setCardExpDate(cardDetails.expiryDate);
        })
        .listen((_) {})
        .addTo(_compositeSubscription);
    isSubmitted.listen((value) {
      if (value) {
        _navigationBloc.events.push(const SuccessRoute());
      }
    }).addTo(_compositeSubscription);
  }

  final CardService _cardService;
  final CardScannerService _cardScannerService;
  final CardValidationService _cardValidationService;
  final RouterBlocType _navigationBloc;

  @override
  ConnectableStream<String> _mapToCardCVVState() => _$setCardCVVEvent
      .map(_cardValidationService.validateCardCVV)
      .startWith('')
      .publishReplay(maxSize: 1);

  @override
  ConnectableStream<String> _mapToCardExpirationDateState() => _$setCardExpDateEvent
      .map(_cardValidationService.validateExpirationDate)
      .startWith('')
      .publishReplay(maxSize: 1);

  @override
  ConnectableStream<String> _mapToCardHolderState() => _$setCardHolderEvent
      .map(_cardValidationService.validateCardHolderName)
      .startWith('')
      .publishReplay(maxSize: 1);

  @override
  ConnectableStream<String> _mapToCardNumberState() => _$setCardNumberEvent
      .map(_cardValidationService.validateCardNumber)
      .startWith('')
      .publishReplay(maxSize: 1);

  @override
  Stream<ErrorModel> _mapToErrorsState() => errorState.mapToErrorModel();

  @override
  Stream<bool> _mapToIsLoadingState() => loadingState;

  @override
  Stream<bool> _mapToShowErrorsState() => _$submitCardEvent
      .switchMap((event) => _validateAllFields().map((_) => true))
      .startWith(false)
      .share();

  @override
  ConnectableStream<bool> _mapToIsSubmittedState() => _$submitCardEvent
      .throttleTime(const Duration(seconds: 1))
      .withLatestFrom4<Result<String>, Result<String>, Result<String>,
              Result<String>, CardRequestModel?>(
          cardNumber.asResultStream(),
          cardHolder.asResultStream(),
          cardExpirationDate.asResultStream(),
          cardCVV.asResultStream(),
          (_, numberResult, nameResult, expDateResult, cvvResult) =>
              _validateAndReturnCard(
                numberResult,
                nameResult,
                expDateResult,
                cvvResult,
              ))
      .where((args) => args != null)
      .exhaustMap(
        (args) => _cardService
            .addCard(cardModel: args!)
            .then((value) => true)
            .asResultStream(),
      )
      .setResultStateHandler(this)
      .whereSuccess()
      .startWith(false)
      .publish();

  CardRequestModel? _validateAndReturnCard(
    Result<String> numberResult,
    Result<String> nameResult,
    Result<String> expDateResult,
    Result<String> cvvResult,
  ) {
    if (numberResult is ResultError ||
        nameResult is ResultError ||
        expDateResult is ResultError ||
        cvvResult is ResultError) {
      return null;
    }
    if (numberResult is ResultLoading ||
        nameResult is ResultLoading ||
        expDateResult is ResultLoading ||
        cvvResult is ResultLoading) {
      return null;
    }

    return CardRequestModel(
      cardNumber: (numberResult as ResultSuccess<String>).data,
      cardHolderName: (nameResult as ResultSuccess<String>).data,
      cardExpDate: (expDateResult as ResultSuccess<String>).data,
      cardCVV: (cvvResult as ResultSuccess<String>).data,
    );
  }

  String _toSpaceSeparatedNumber(String number) {
    return number.replaceAllMapped(
      RegExp(r'.{4}'),
      (match) => '${match.group(0)} ',
    );
  }
}
