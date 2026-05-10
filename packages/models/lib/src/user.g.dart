// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String,
  currentRole: $enumDecode(_$UserRoleEnumMap, json['currentRole']),
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
  'currentRole': _$UserRoleEnumMap[instance.currentRole]!,
  'profileImageUrl': instance.profileImageUrl,
};

const _$UserRoleEnumMap = {
  UserRole.commuter: 'commuter',
  UserRole.driver: 'driver',
};
