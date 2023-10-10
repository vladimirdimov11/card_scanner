// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'success_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class SuccessBlocType extends RxBlocTypeBase {
  SuccessBlocEvents get events;
  SuccessBlocStates get states;
}

/// [$SuccessBloc] extended by the [SuccessBloc]
/// {@nodoc}
abstract class $SuccessBloc extends RxBlocBase
    implements SuccessBlocEvents, SuccessBlocStates, SuccessBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [scanAgain]
  final _$scanAgainEvent = PublishSubject<void>();

  @override
  void scanAgain() => _$scanAgainEvent.add(null);

  @override
  SuccessBlocEvents get events => this;

  @override
  SuccessBlocStates get states => this;

  @override
  void dispose() {
    _$scanAgainEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
