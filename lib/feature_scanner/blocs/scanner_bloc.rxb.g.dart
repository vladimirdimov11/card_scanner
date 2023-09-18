// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'scanner_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class ScannerBlocType extends RxBlocTypeBase {
  ScannerBlocEvents get events;
  ScannerBlocStates get states;
}

/// [$ScannerBloc] extended by the [ScannerBloc]
/// {@nodoc}
abstract class $ScannerBloc extends RxBlocBase
    implements ScannerBlocEvents, ScannerBlocStates, ScannerBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [setCardNumber]
  final _$setCardNumberEvent = BehaviorSubject<String>.seeded('');

  /// Тhe [Subject] where events sink to by calling [setCardHolder]
  final _$setCardHolderEvent = BehaviorSubject<String>.seeded('');

  /// Тhe [Subject] where events sink to by calling [setCardExpDate]
  final _$setCardExpDateEvent = BehaviorSubject<String>.seeded('');

  /// Тhe [Subject] where events sink to by calling [setCardCVV]
  final _$setCardCVVEvent = BehaviorSubject<String>.seeded('');

  /// Тhe [Subject] where events sink to by calling [submitCard]
  final _$submitCardEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [scanCard]
  final _$scanCardEvent = PublishSubject<void>();

  /// The state of [cardNumber] implemented in [_mapToCardNumberState]
  late final ConnectableStream<String> _cardNumberState =
      _mapToCardNumberState();

  /// The state of [cardHolder] implemented in [_mapToCardHolderState]
  late final ConnectableStream<String> _cardHolderState =
      _mapToCardHolderState();

  /// The state of [cardExpirationDate] implemented in
  /// [_mapToCardExpirationDateState]
  late final ConnectableStream<String> _cardExpirationDateState =
      _mapToCardExpirationDateState();

  /// The state of [cardCVV] implemented in [_mapToCardCVVState]
  late final ConnectableStream<String> _cardCVVState = _mapToCardCVVState();

  /// The state of [isSubmitted] implemented in [_mapToIsSubmittedState]
  late final ConnectableStream<bool> _isSubmittedState =
      _mapToIsSubmittedState();

  /// The state of [showErrors] implemented in [_mapToShowErrorsState]
  late final Stream<bool> _showErrorsState = _mapToShowErrorsState();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<ErrorModel> _errorsState = _mapToErrorsState();

  @override
  void setCardNumber(String cardNumber) => _$setCardNumberEvent.add(cardNumber);

  @override
  void setCardHolder(String cardHolder) => _$setCardHolderEvent.add(cardHolder);

  @override
  void setCardExpDate(String cardExpDate) =>
      _$setCardExpDateEvent.add(cardExpDate);

  @override
  void setCardCVV(String cardCVV) => _$setCardCVVEvent.add(cardCVV);

  @override
  void submitCard() => _$submitCardEvent.add(null);

  @override
  void scanCard() => _$scanCardEvent.add(null);

  @override
  ConnectableStream<String> get cardNumber => _cardNumberState;

  @override
  ConnectableStream<String> get cardHolder => _cardHolderState;

  @override
  ConnectableStream<String> get cardExpirationDate => _cardExpirationDateState;

  @override
  ConnectableStream<String> get cardCVV => _cardCVVState;

  @override
  ConnectableStream<bool> get isSubmitted => _isSubmittedState;

  @override
  Stream<bool> get showErrors => _showErrorsState;

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<ErrorModel> get errors => _errorsState;

  ConnectableStream<String> _mapToCardNumberState();

  ConnectableStream<String> _mapToCardHolderState();

  ConnectableStream<String> _mapToCardExpirationDateState();

  ConnectableStream<String> _mapToCardCVVState();

  ConnectableStream<bool> _mapToIsSubmittedState();

  Stream<bool> _mapToShowErrorsState();

  Stream<bool> _mapToIsLoadingState();

  Stream<ErrorModel> _mapToErrorsState();

  @override
  ScannerBlocEvents get events => this;

  @override
  ScannerBlocStates get states => this;

  @override
  void dispose() {
    _$setCardNumberEvent.close();
    _$setCardHolderEvent.close();
    _$setCardExpDateEvent.close();
    _$setCardCVVEvent.close();
    _$submitCardEvent.close();
    _$scanCardEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
