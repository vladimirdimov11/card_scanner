import 'package:json_annotation/json_annotation.dart';

part 'card_request_model.g.dart';

@JsonSerializable()
class CardRequestModel {
  CardRequestModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardExpDate,
    required this.cardCVV,
  });

  final String cardNumber;
  final String cardHolderName;
  final String cardExpDate;
  final String cardCVV;

  factory CardRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CardRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardRequestModelToJson(this);
}
