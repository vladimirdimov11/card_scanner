import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../lib_router/blocs/router_bloc.dart';

part 'success_bloc.rxb.g.dart';

/// A contract class containing all events of the SuccessBloC.
abstract class SuccessBlocEvents {
  void scanAgain();
}

/// A contract class containing all states of the SuccessBloC.
abstract class SuccessBlocStates {}

@RxBloc()
class SuccessBloc extends $SuccessBloc {
  SuccessBloc(this._navigationBloc) {
    _$scanAgainEvent.throttleTime(const Duration(seconds: 1)).listen((_) {
      _navigationBloc.events.pop();
    }).addTo(_compositeSubscription);
  }

  final RouterBlocType _navigationBloc;
}
