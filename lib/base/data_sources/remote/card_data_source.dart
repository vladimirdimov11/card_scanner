import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/request_model/card_request_model.dart';

part 'card_data_source.g.dart';

@RestApi()
abstract class CardDataSource {
  factory CardDataSource(Dio dio, {String baseUrl}) = _CardDataSource;

  @POST('/api/card')
  Future<void> addCard(@Body() CardRequestModel cardModel);
}
