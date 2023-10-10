// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardRequestModel _$CardRequestModelFromJson(Map<String, dynamic> json) =>
    CardRequestModel(
      cardNumber: json['cardNumber'] as String,
      cardHolderName: json['cardHolderName'] as String,
      cardExpDate: json['cardExpDate'] as String,
      cardCVV: json['cardCVV'] as String,
    );

Map<String, dynamic> _$CardRequestModelToJson(CardRequestModel instance) =>
    <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'cardHolderName': instance.cardHolderName,
      'cardExpDate': instance.cardExpDate,
      'cardCVV': instance.cardCVV,
    };
