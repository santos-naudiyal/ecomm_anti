import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_entity.freezed.dart';
part 'address_entity.g.dart';

@freezed
class AddressEntity with _$AddressEntity {
  const factory AddressEntity({
    required String id,
    required String name,
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String phoneNumber,
    @Default(false) bool isDefault,
  }) = _AddressEntity;

  factory AddressEntity.fromJson(Map<String, dynamic> json) =>
      _$AddressEntityFromJson(json);
}
