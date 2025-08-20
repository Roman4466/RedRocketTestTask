// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseDtoImpl _$$LoginResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LoginResponseDtoImpl(
  token: json['token'] as String,
  refreshToken: json['refreshToken'] as String,
  user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$LoginResponseDtoImplToJson(
  _$LoginResponseDtoImpl instance,
) => <String, dynamic>{
  'token': instance.token,
  'refreshToken': instance.refreshToken,
  'user': instance.user,
};
