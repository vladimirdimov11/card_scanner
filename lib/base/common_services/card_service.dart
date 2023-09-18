import '../app/config/environment_config.dart';
import '../models/request_model/card_request_model.dart';
import '../repositories/card_repository.dart';

class CardService {
  CardService(this._cardRepository,this._environmentConfig);

  final CardRepository _cardRepository;
  final EnvironmentConfig _environmentConfig;

  Future<void> addCard({required CardRequestModel cardModel}) {
    /// Here we can add additional service logic before
    /// before we turn to the repositories layer

    // don't execute the request on development env
    if (_environmentConfig == EnvironmentConfig.development) {
      return Future.delayed(const Duration(seconds: 3));
    }

    return _cardRepository.addCard(cardModel: cardModel);
  }
}
