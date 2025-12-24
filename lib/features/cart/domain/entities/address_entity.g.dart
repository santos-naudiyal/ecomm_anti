// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressEntityImpl _$$AddressEntityImplFromJson(Map<String, dynamic> json) =>
    _$AddressEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      phoneNumber: json['phoneNumber'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$$AddressEntityImplToJson(_$AddressEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'phoneNumber': instance.phoneNumber,
      'isDefault': instance.isDefault,
    };
