import '../models/request_model/card_request_model.dart';
import '../repositories/card_repository.dart';

class CardService {
  CardService(this._cardRepository);

  final CardRepository _cardRepository;

  Future<void> addCard({required CardRequestModel cardModel}) {
    /// Here we can add additional service logic
    /// before we turn to the repositories layer
    return _cardRepository.addCard(cardModel: cardModel);
  }
}
