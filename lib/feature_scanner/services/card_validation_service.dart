import '../../assets.dart';
import '../../base/models/errors/error_model.dart';
import '../../base/utils/validation_utils.dart';

class CardValidationService {
  const CardValidationService();

  String validateCardNumber(String cardNumber) {
    if (cardNumber.isEmpty) {
      throw FieldRequiredErrorModel(
        fieldKey: I18nFieldKeys.cardNumber,
        fieldValue: cardNumber,
      );
    }
    if (!ValidationUtils.isValidCardNumber(cardNumber)) {
      throw FieldErrorModel(
        errorKey: I18nErrorKeys.invalidCardNumber,
        fieldValue: cardNumber,
      );
    }
    return cardNumber;
  }

  String validateCardHolderName(String cardHolderName) {
    if (cardHolderName.isEmpty) {
      throw FieldRequiredErrorModel(
        fieldKey: I18nFieldKeys.cardHolderName,
        fieldValue: cardHolderName,
      );
    }

    //card convention allow only latin letters
    if (cardHolderName.length < 3 ||
        cardHolderName.length > 64 ||
        !ValidationUtils.containsLatinLettersOnly(cardHolderName)) {
      throw FieldErrorModel(
        errorKey: I18nErrorKeys.invalidCardHolder,
        fieldValue: cardHolderName,
      );
    }

    return cardHolderName;
  }

  String validateExpirationDate(String expDate) {
    if (expDate.isEmpty) {
      throw FieldRequiredErrorModel(
        fieldKey: I18nFieldKeys.cardExpDate,
        fieldValue: expDate,
      );
    }

    if (!ValidationUtils.isValidExpirationDate(expDate)) {
      throw FieldErrorModel(
        errorKey: I18nErrorKeys.invalidExpirationDate,
        fieldValue: expDate,
      );
    }

    return expDate;
  }

  String validateCardCVV(String cardCVV) {
    if (cardCVV.isEmpty) {
      throw FieldRequiredErrorModel(
        fieldKey: I18nFieldKeys.cardCVV,
        fieldValue: cardCVV,
      );
    }

    if (cardCVV.length < 3 ||
        cardCVV.length > 4 ||
        !ValidationUtils.containsNumbersOnly(cardCVV)) {
      throw FieldErrorModel(
        errorKey: I18nErrorKeys.invalidCVV,
        fieldValue: cardCVV,
      );
    }

    return cardCVV;
  }
}
