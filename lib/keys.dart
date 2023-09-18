import 'package:flutter/foundation.dart';

typedef K = Keys;

class Keys {
  const Keys();

  // Scanner Page
  static const scannerCardNumberField = Key('scannerCardNumberField');
  static const scannerCardHolderField = Key('scannerCardHolderField');
  static const scannerCardExpDateField = Key('scannerCardExpDateField');
  static const scannerCardCVVField = Key('scannerCardCVVField');
  static const scannerSubmitButton = Key('scannerSubmitButton');

}
