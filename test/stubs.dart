import 'package:card_scanner/base/models/request_model/card_request_model.dart';

class Stubs {
  static CardRequestModel get cardRequestModel => CardRequestModel(
        cardNumber: cardNumber,
        cardHolderName: cardHolder,
        cardExpDate: cardExpDate,
        cardCVV: cardCVV,
      );
  static String get cardNumber => '4111111111111111';
  static String get cardHolder => 'Vladimir D';
  static String get cardExpDate => '1127';
  static String get cardCVV => '123';
}
