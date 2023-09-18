import '../common_mappers/error_mappers/error_mapper.dart';
import '../data_sources/remote/card_data_source.dart';
import '../models/request_model/card_request_model.dart';

class CardRepository {
  CardRepository(this._errorMapper, this._dataSource);

  final ErrorMapper _errorMapper;
  final CardDataSource _dataSource;

  Future<void> addCard({required CardRequestModel cardModel}) {
    return _errorMapper.execute(() => _dataSource.addCard(cardModel));
  }
}
