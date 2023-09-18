part of 'scanner_bloc.dart';

extension _ScannerBlocExtensions on ScannerBloc {
  Stream<bool> _validateAllFields() =>
      Rx.combineLatest4<String, String, String, String, bool>(
        cardHolder,
        cardNumber,
        cardExpirationDate,
        cardCVV,
        (cardHolderName, cardNumber, cardExpDate, cardCVV) => true,
      ).onErrorReturn(false);
}
