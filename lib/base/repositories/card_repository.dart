import '../app/config/environment_config.dart';
import '../common_mappers/error_mappers/error_mapper.dart';
import '../data_sources/remote/card_data_source.dart';
import '../models/request_model/card_request_model.dart';

class CardRepository {
  CardRepository(
    this._errorMapper,
    this._dataSource,
    this._environmentConfig,
  );

  final ErrorMapper _errorMapper;
  final CardDataSource _dataSource;
  final EnvironmentConfig _environmentConfig;

  Future<void> addCard({required CardRequestModel cardModel}) {
    // don't execute the request on development env
    if (_environmentConfig == EnvironmentConfig.development) {
      return Future.delayed(const Duration(seconds: 3));
    }

    return _errorMapper.execute(() => _dataSource.addCard(cardModel));
  }
}
